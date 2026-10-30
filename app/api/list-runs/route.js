// Replaces the original's Netlify "list-runs" function (same response shape).
import { NextResponse } from 'next/server';
import { db, must } from '@/lib/supabase';
import { tick } from '@/lib/queue';
export const dynamic = 'force-dynamic';
export const maxDuration = 30;

export async function GET(req) {
  try {
    const sb = db();
    const limit = Math.min(Number(req.nextUrl.searchParams.get('limit')) || 8, 30);
    // keep an active run moving while someone is watching the admin tab
    const active = must(await sb.from('runs').select('id').eq('status', 'running').limit(1));
    if (active.length) { try { await tick(6000); } catch (e) { console.error(e); } }

    const runs = must(await sb.from('runs').select('*').neq('triggered_by', 'import').order('created_at', { ascending: false }).limit(limit));
    const ids = runs.map((r) => r.id);
    const res = ids.length ? must(await sb.from('results').select('run_id,status').in('run_id', ids)) : [];
    const out = runs.map((r) => {
      const mine = res.filter((x) => x.run_id === r.id);
      const started = mine.some((x) => x.status !== 'pending');
      const ok = mine.some((x) => x.status === 'completed');
      const isCron = r.triggered_by === 'cron';
      return {
        created_at: r.created_at,
        event: isCron ? 'schedule' : 'workflow_dispatch',
        name: isCron ? 'Scheduled' : `On-demand · ${r.scope || 'full'} · ${r.devices || 'both'}`,
        status: r.status === 'done' ? 'completed' : started ? 'in_progress' : 'queued',
        conclusion: r.status === 'done' ? (ok ? 'success' : 'failure') : null,
        url: null,
      };
    });
    return NextResponse.json({ ok: true, runs: out });
  } catch (e) {
    return NextResponse.json({ ok: false, error: e.message }, { status: 500 });
  }
}
