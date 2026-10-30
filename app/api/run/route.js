import { NextResponse } from 'next/server';
import { waitUntil } from '@vercel/functions';
import { requestRole } from '@/lib/auth';
import { startRun, tick, chainNextTick } from '@/lib/queue';
export const dynamic = 'force-dynamic';
export const maxDuration = 60;

// Admin: one-click "run today". Body { urlIds?: string[] } to re-run selected pages only.
export async function POST(req) {
  if ((await requestRole(req)) !== 'admin') return NextResponse.json({ error: 'Admin only' }, { status: 403 });
  const { urlIds } = await req.json().catch(() => ({}));
  try {
    const out = await startRun({ trigger: 'manual', urlIds });
    const t = await tick(8000); // submit the first batch right away
    if (t.remaining) waitUntil(chainNextTick(req.nextUrl.origin));
    return NextResponse.json({ ...out, ...t });
  } catch (e) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
