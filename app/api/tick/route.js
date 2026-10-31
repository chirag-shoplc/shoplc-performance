import { NextResponse } from 'next/server';
import { waitUntil } from '@vercel/functions';
import { requestRole, isCron } from '@/lib/auth';
import { tick, kickWorker } from '@/lib/queue';
export const dynamic = 'force-dynamic';
export const fetchCache = 'force-no-store';
export const revalidate = 0;
export const maxDuration = 60;

// Works the GTmetrix queue.
//  - Background worker (Authorization: Bearer CRON_SECRET): answers at once, then works for ~45s
//    after the response and hands over to a fresh invocation while tests remain.
//  - Dashboard (no secret): one short pass, answered inline.
export async function POST(req) {
  const origin = req.nextUrl.origin;
  if (isCron(req)) {
    waitUntil((async () => {
      try {
        const out = await tick(45000);
        if (out.remaining) await kickWorker(origin);
      } catch (e) {
        console.error('tick worker: ' + e.message);
        await kickWorker(origin); // transient error — keep the queue alive
      }
    })());
    return NextResponse.json({ accepted: true }, { status: 202 });
  }
  if (!(await requestRole(req))) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  try {
    return NextResponse.json(await tick(10000));
  } catch (e) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
