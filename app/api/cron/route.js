import { NextResponse } from 'next/server';
import { waitUntil } from '@vercel/functions';
import { isCron } from '@/lib/auth';
import { startRun, tick, chainNextTick } from '@/lib/queue';
export const dynamic = 'force-dynamic';
export const fetchCache = 'force-no-store';
export const revalidate = 0;
export const maxDuration = 60;

// Vercel Cron (see vercel.json) — daily scheduled run.
export async function GET(req) {
  if (!isCron(req)) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  try {
    const out = await startRun({ trigger: 'cron' });
    const t = await tick(40000);
    if (t.remaining) waitUntil(chainNextTick(req.nextUrl.origin));
    return NextResponse.json({ ...out, ...t });
  } catch (e) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
