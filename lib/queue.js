import { db, must } from './supabase';
import { startTest, checkTest, reportToMetrics, GtmetrixError } from './gtmetrix';

export const DEVICES = ['desktop', 'mobile'];
const ACTIVE = ['pending', 'submitting', 'submitted'];
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

export function today() {
  const tz = process.env.APP_TIMEZONE || 'Europe/London';
  return new Intl.DateTimeFormat('en-CA', { timeZone: tz, year: 'numeric', month: '2-digit', day: '2-digit' }).format(new Date());
}

/**
 * Queue a run for today. urlIds = optional subset (re-run selected pages).
 * Returns the run row. If a run is already in progress it is returned instead.
 */
export async function startRun({ trigger = 'manual', urlIds = null } = {}) {
  const sb = db();
  const running = must(await sb.from('runs').select('*').eq('status', 'running').limit(1));
  if (running.length) return { run: running[0], alreadyRunning: true };

  let q = sb.from('monitored_urls').select('*').eq('active', true).order('sort');
  if (urlIds?.length) q = q.in('id', urlIds);
  const urls = must(await q);
  if (!urls.length) throw new Error('No active URLs to test');

  const run_date = today();
  const run = must(await sb.from('runs').insert({ run_date, triggered_by: trigger }).select().single());
  const rows = urls.flatMap((u) =>
    DEVICES.map((device) => ({
      run_id: run.id, url_id: u.id, run_date, page_type: u.page_type, url: u.url,
      device, location: u.location, status: 'pending',
    }))
  );
  must(await sb.from('results').insert(rows));
  return { run, alreadyRunning: false, queued: rows.length };
}

async function setRow(id, patch) {
  must(await db().from('results').update({ ...patch, updated_at: new Date().toISOString() }).eq('id', id));
}

/** One pass: poll in-flight tests, then submit pending ones up to the concurrency limit. */
async function pass() {
  const sb = db();
  const max = Number(process.env.GTMETRIX_MAX_CONCURRENT || 2);
  let credits;

  // Recover rows stuck in 'submitting' (function died mid-submit)
  const stale = new Date(Date.now() - 3 * 60 * 1000).toISOString();
  await sb.from('results').update({ status: 'pending' }).eq('status', 'submitting').lt('updated_at', stale);

  // 1) Poll in-flight
  const inflight = must(await sb.from('results').select('id,gtmetrix_test_id').eq('status', 'submitted'));
  let stillRunning = 0;
  for (const r of inflight) {
    try {
      const res = await checkTest(r.gtmetrix_test_id);
      if (res.state === 'completed') await setRow(r.id, { status: 'completed', error: null, ...reportToMetrics(res.report) });
      else if (res.state === 'error') await setRow(r.id, { status: 'error', error: res.error });
      else stillRunning++;
    } catch (e) {
      if (e instanceof GtmetrixError && e.status === 404) await setRow(r.id, { status: 'error', error: e.message });
      else stillRunning++; // transient — retry next pass
    }
  }

  // 2) Submit pending
  let slots = Math.max(0, max - stillRunning);
  if (slots > 0) {
    const pending = must(await sb.from('results').select('id,url,device,location').eq('status', 'pending').order('created_at').order('page_type').limit(slots));
    for (const p of pending) {
      // atomic claim so two concurrent ticks never submit the same row
      const claimed = must(await sb.from('results').update({ status: 'submitting', updated_at: new Date().toISOString() }).eq('id', p.id).eq('status', 'pending').select('id'));
      if (!claimed.length) continue;
      try {
        const { testId, creditsLeft } = await startTest(p);
        credits = creditsLeft ?? credits;
        await setRow(p.id, { status: 'submitted', gtmetrix_test_id: testId });
      } catch (e) {
        if (e instanceof GtmetrixError && e.status === 429) { await setRow(p.id, { status: 'pending' }); break; } // concurrency/rate limit
        await setRow(p.id, { status: 'error', error: e.message });
      }
    }
  }

  // 3) Close finished runs
  const runs = must(await sb.from('runs').select('id').eq('status', 'running'));
  for (const run of runs) {
    const open = must(await sb.from('results').select('id', { count: 'exact', head: false }).eq('run_id', run.id).in('status', ACTIVE).limit(1));
    if (!open.length) must(await sb.from('runs').update({ status: 'done', finished_at: new Date().toISOString() }).eq('id', run.id));
  }

  const remaining = must(await sb.from('results').select('id').in('status', ACTIVE));
  return { remaining: remaining.length, credits };
}

/** Work the queue for up to budgetMs. */
export async function tick(budgetMs = 45000) {
  const until = Date.now() + budgetMs;
  let out = { remaining: 0 };
  let credits;
  do {
    out = await pass();
    credits = out.credits ?? credits;
    out.credits = credits;
    if (!out.remaining) break;
    if (Date.now() + 8000 > until) break;
    await sleep(6000);
  } while (Date.now() < until);
  return out;
}

/** Fire-and-forget the next tick so the queue keeps moving without a browser open. */
export function chainNextTick(origin) {
  const secret = process.env.CRON_SECRET;
  if (!secret) return Promise.resolve();
  // Only wait long enough for the request to be accepted; the next invocation runs independently.
  return fetch(`${origin}/api/tick`, {
    method: 'POST',
    headers: { authorization: `Bearer ${secret}` },
    signal: AbortSignal.timeout(2500),
  }).catch(() => {});
}
