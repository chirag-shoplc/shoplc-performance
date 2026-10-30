// Replaces the original's Netlify "trigger-run" function.
import { NextResponse } from 'next/server';
import { waitUntil } from '@vercel/functions';
import { COOKIE, makeSession, isAdminPassword } from '@/lib/auth';
import { startRun, tick, chainNextTick } from '@/lib/queue';
export const dynamic = 'force-dynamic';
export const fetchCache = 'force-no-store';
export const revalidate = 0;
export const maxDuration = 60;

export async function POST(req) {
  const body = await req.json().catch(() => ({}));
  if (!isAdminPassword(String(body.passphrase || '').trim())) return NextResponse.json({ ok: false, error: 'Incorrect passphrase.' }, { status: 401 });

  let res;
  if (body.verify) {
    res = NextResponse.json({ ok: true });
  } else {
    try {
      const pageKeys = body.only ? String(body.only).split(',').map((s) => s.trim()).filter(Boolean) : null;
      const out = await startRun({ trigger: 'manual', pageKeys, device: body.device || 'both' });
      if (out.alreadyRunning) return NextResponse.json({ ok: false, error: 'A run is already in progress — wait for it to finish.' }, { status: 409 });
      const t = await tick(8000);
      if (t.remaining) waitUntil(chainNextTick(req.nextUrl.origin));
      res = NextResponse.json({ ok: true, queued: out.queued });
    } catch (e) {
      return NextResponse.json({ ok: false, error: e.message }, { status: 500 });
    }
  }
  // admin session cookie also unlocks saving on the Monitored URLs tab
  const { value, maxAge } = await makeSession('admin');
  res.cookies.set(COOKIE, value, { httpOnly: true, secure: process.env.NODE_ENV === 'production', sameSite: 'lax', path: '/', maxAge });
  return res;
}
