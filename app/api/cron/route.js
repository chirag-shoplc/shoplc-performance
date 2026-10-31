import { NextResponse } from 'next/server';
import { isCron } from '@/lib/auth';
import { startRun, kickWorker } from '@/lib/queue';
import { getSetting } from '@/lib/settings';
export const dynamic = 'force-dynamic';
export const fetchCache = 'force-no-store';
export const revalidate = 0;
export const maxDuration = 60;

// Vercel Cron (see vercel.json) — daily scheduled run. Can be switched off from Run Tests - Admin.
export async function GET(req) {
  if (!isCron(req)) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  try {
    if ((await getSetting('auto_run', true)) === false) {
      console.log('cron: daily automatic run is switched off — skipped');
      return NextResponse.json({ skipped: true, reason: 'Daily automatic run is switched off' });
    }
    const out = await startRun({ trigger: 'cron' });
    console.log('cron: ' + (out.alreadyRunning ? 'a run is already in progress' : `queued ${out.queued} tests`));
    await kickWorker(req.nextUrl.origin);
    return NextResponse.json({ ok: true, alreadyRunning: out.alreadyRunning, queued: out.queued || 0 });
  } catch (e) {
    console.error('cron: ' + e.message);
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
