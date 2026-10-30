import { NextResponse } from 'next/server';
import { requestRole } from '@/lib/auth';
import { db, must } from '@/lib/supabase';
export const dynamic = 'force-dynamic';

// Replace the whole URL list in one save (admin only)
export async function PUT(req) {
  if ((await requestRole(req)) !== 'admin') return NextResponse.json({ error: 'Admin only' }, { status: 403 });
  const { urls, changedBy } = await req.json();
  if (!Array.isArray(urls)) return NextResponse.json({ error: 'urls[] required' }, { status: 400 });
  const who = String(changedBy || '').trim().slice(0, 60);
  if (!who) return NextResponse.json({ error: 'Enter your name so the change is logged' }, { status: 400 });
  const sb = db();
  const clean = [];
  for (const [i, u] of urls.entries()) {
    let parsed;
    try { parsed = new URL(String(u.url).trim()); } catch { return NextResponse.json({ error: `Invalid URL on row ${i + 1}` }, { status: 400 }); }
    if (!/^https?:$/.test(parsed.protocol)) return NextResponse.json({ error: `Row ${i + 1} must be http(s)` }, { status: 400 });
    clean.push({
      ...(u.id ? { id: u.id } : {}),
      page_type: String(u.page_type || 'Page').trim().slice(0, 80),
      url: parsed.toString(),
      location: String(u.location || process.env.GTMETRIX_LOCATION || 'Chicago, IL, USA'),
      active: u.active !== false,
      sort: i + 1,
    });
  }
  const existing = must(await sb.from('monitored_urls').select('*'));
  const keep = new Set(clean.filter((u) => u.id).map((u) => u.id));
  const remove = existing.map((e) => e.id).filter((id) => !keep.has(id));

  // audit trail
  const byId = new Map(existing.map((e) => [e.id, e]));
  const log = [];
  for (const u of clean) {
    const old = u.id && byId.get(u.id);
    if (!old) log.push({ changed_by: who, action: 'added', page_type: u.page_type, new_url: u.url });
    else if (old.url !== u.url || old.page_type !== u.page_type || old.location !== u.location || old.active !== u.active)
      log.push({ changed_by: who, action: old.active !== u.active ? (u.active ? 'resumed' : 'paused') : 'changed', page_type: u.page_type, old_url: old.url, new_url: u.url });
  }
  for (const id of remove) { const o = byId.get(id); log.push({ changed_by: who, action: 'removed', page_type: o.page_type, old_url: o.url }); }
  if (log.length) must(await sb.from('url_changes').insert(log));
  if (remove.length) must(await sb.from('monitored_urls').delete().in('id', remove));
  const withId = clean.filter((u) => u.id);
  const fresh = clean.filter((u) => !u.id);
  if (withId.length) must(await sb.from('monitored_urls').upsert(withId));
  if (fresh.length) must(await sb.from('monitored_urls').insert(fresh));
  const urlsOut = must(await sb.from('monitored_urls').select('*').order('sort'));
  return NextResponse.json({ urls: urlsOut });
}
