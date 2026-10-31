// Run Tests - Admin: daily automatic run on/off + GTmetrix credit balance.
import { NextResponse } from 'next/server';
import { isAdminPassword, isAdminRequest } from '@/lib/auth';
import { getSetting, setSetting } from '@/lib/settings';
import { accountStatus } from '@/lib/gtmetrix';
import { db, must } from '@/lib/supabase';
import { FUNNEL_TYPES } from '@/lib/pages';
export const dynamic = 'force-dynamic';
export const fetchCache = 'force-no-store';
export const revalidate = 0;

async function summary() {
  const autoRun = (await getSetting('auto_run', true)) !== false;
  let credits = null, refill = null, creditsError = null;
  try { ({ credits, refill } = await accountStatus()); } catch (e) { creditsError = e.message; }
  const urls = must(await db().from('monitored_urls').select('page_type').eq('active', true));
  const dailyPages = urls.filter((u) => !FUNNEL_TYPES.has(u.page_type)).length;
  return { ok: true, autoRun, schedule: '05:00 UTC daily', dailyPages, testsPerRun: dailyPages * 2, credits, refill, creditsError };
}

export async function GET() {
  try { return NextResponse.json(await summary()); }
  catch (e) { return NextResponse.json({ ok: false, error: e.message }, { status: 500 }); }
}

export async function POST(req) {
  const body = await req.json().catch(() => ({}));
  if (!isAdminPassword(String(body.passphrase || '').trim()) && !(await isAdminRequest(req)))
    return NextResponse.json({ ok: false, error: 'Incorrect passphrase.' }, { status: 401 });
  try {
    if (typeof body.autoRun === 'boolean') await setSetting('auto_run', body.autoRun);
    return NextResponse.json(await summary());
  } catch (e) {
    return NextResponse.json({ ok: false, error: e.message }, { status: 500 });
  }
}
