import { NextResponse } from 'next/server';
import { waitUntil } from '@vercel/functions';
import { requestRole, isCron } from '@/lib/auth';
import { tick, chainNextTick } from '@/lib/queue';
export const dynamic = 'force-dynamic';
export const fetchCache = 'force-no-store';
export const revalidate = 0;
export const maxDuration = 60;

// Works the GTmetrix queue. Called by the chain (CRON_SECRET) or by the dashboard while a run is active.
export async function POST(req) {
  const chained = isCron(req);
  if (!chained && !(await requestRole(req))) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  try {
    const out = await tick(chained ? 45000 : 10000);
    if (chained && out.remaining) waitUntil(chainNextTick(req.nextUrl.origin));
    return NextResponse.json(out);
  } catch (e) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
