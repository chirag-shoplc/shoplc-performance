// Minimal stand-in for the Supabase REST calls the original dashboard makes.
// Reads are public (read-only dashboard); writes require the admin session cookie.
import { NextResponse } from 'next/server';
import { db, must } from '@/lib/supabase';
import { isAdminRequest } from '@/lib/auth';
import { pageKey, pageName, toMonitorRow, SITE } from '@/lib/pages';
export const dynamic = 'force-dynamic';
export const fetchCache = 'force-no-store';
export const revalidate = 0;

const HISTORY_DAYS = 12;

async function allCompleted(sb, since) {
  const out = [];
  for (let from = 0; ; from += 1000) {
    const page = must(await sb.from('results').select('*').eq('status', 'completed').gte('run_date', since)
      .order('run_date').order('updated_at').range(from, from + 999));
    out.push(...page);
    if (page.length < 1000) return out;
  }
}

export async function GET(req, { params }) {
  const sb = db();
  try {
    if (params.table === 'benchmark_runs') {
      const urls = must(await sb.from('monitored_urls').select('*'));
      const keyById = new Map(urls.map((u) => [u.id, pageKey(u)]));
      const dates = [...new Set(must(await sb.from('runs').select('run_date').order('run_date', { ascending: false }).limit(500)).map((r) => r.run_date))];
      if (!dates.length) return NextResponse.json([]);
      const since = dates[Math.min(HISTORY_DAYS, dates.length) - 1];
      const latest = new Map(); // date|page|device -> newest completed row (re-runs win)
      for (const r of await allCompleted(sb, since)) {
        const key = keyById.get(r.url_id) || pageKey({ page_type: r.page_type });
        latest.set(`${r.run_date}|${key}|${r.device}`, toMonitorRow(r, key));
      }
      const rows = [...latest.values()].sort((a, b) => (a.run_date < b.run_date ? 1 : a.run_date > b.run_date ? -1 : a.device.localeCompare(b.device)));
      return NextResponse.json(rows);
    }
    if (params.table === 'monitored_urls') {
      const urls = must(await sb.from('monitored_urls').select('*').eq('active', true).order('sort'));
      return NextResponse.json(urls.map((u) => ({ page_key: pageKey(u), url: u.url })));
    }
    if (params.table === 'url_change_log') {
      const log = must(await sb.from('url_changes').select('*').order('created_at', { ascending: false }).limit(100));
      return NextResponse.json(log.map((c) => ({
        page_key: c.page_key || null, site: c.site || SITE,
        page_name: (c.page_name || c.page_type) + (c.action === 'added' ? ' \u00b7 added' : c.action === 'removed' ? ' \u00b7 removed' : ''),
        old_url: c.old_url, new_url: c.new_url, changed_by: c.changed_by, changed_at: c.created_at,
      })));
    }
    return NextResponse.json({ message: 'unknown table' }, { status: 404 });
  } catch (e) {
    console.error(e);
    return NextResponse.json({ message: e.message }, { status: 500 });
  }
}

export async function POST(req, { params }) {
  if (!(await isAdminRequest(req))) return NextResponse.json({ message: 'Admin passphrase required' }, { status: 401 });
  const sb = db();
  const body = await req.json().catch(() => null);
  const rows = Array.isArray(body) ? body : body ? [body] : [];
  try {
    if (params.table === 'monitored_urls') {
      const urls = must(await sb.from('monitored_urls').select('*'));
      for (const r of rows) {
        if (!/^https?:\/\/.+/i.test(r.url || '')) return NextResponse.json({ message: 'Invalid URL' }, { status: 400 });
        const hit = urls.find((u) => pageKey(u) === r.page_key);
        if (hit) {
          // URL edit, or re-adding a page that was removed earlier (keeps its history)
          const patch = { url: r.url, active: true };
          if (!hit.active && r.type) Object.assign(patch, { page_type: String(r.type).slice(0, 80), name: r.name || hit.name });
          must(await sb.from('monitored_urls').update(patch).eq('id', hit.id));
        } else {
          const sort = Math.max(0, ...urls.map((u) => u.sort || 0)) + 1;
          must(await sb.from('monitored_urls').insert({
            page_key: String(r.page_key).slice(0, 80), page_type: String(r.type || r.page_key).slice(0, 80),
            name: r.name || null, site: r.site || SITE, url: r.url,
            location: process.env.GTMETRIX_LOCATION_LABEL || 'Chicago, IL, USA', sort,
          }));
        }
      }
      return new Response(null, { status: 201 });
    }
    if (params.table === 'url_change_log') {
      must(await sb.from('url_changes').insert(rows.map((r) => ({
        changed_by: String(r.changed_by || 'admin').slice(0, 60),
        action: ['added', 'removed'].includes(r.action) ? r.action : 'changed',
        page_key: r.page_key, site: r.site || SITE, page_name: r.page_name, page_type: r.page_name,
        old_url: r.old_url, new_url: r.new_url,
      }))));
      return new Response(null, { status: 201 });
    }
    return NextResponse.json({ message: 'unknown table' }, { status: 404 });
  } catch (e) {
    console.error(e);
    return NextResponse.json({ message: e.message }, { status: 500 });
  }
}

// Remove a monitored page (admin). Soft delete: the page stops being tested, its history stays.
export async function DELETE(req, { params }) {
  if (!(await isAdminRequest(req))) return NextResponse.json({ message: 'Admin passphrase required' }, { status: 401 });
  if (params.table !== 'monitored_urls') return NextResponse.json({ message: 'not allowed' }, { status: 405 });
  const key = (req.nextUrl.searchParams.get('page_key') || '').replace(/^eq\./, '');
  if (!key) return NextResponse.json({ message: 'page_key required' }, { status: 400 });
  try {
    const sb = db();
    const urls = must(await sb.from('monitored_urls').select('*'));
    const hit = urls.find((u) => pageKey(u) === key);
    if (!hit) return NextResponse.json({ message: 'not found' }, { status: 404 });
    if (!hit.page_key) must(await sb.from('monitored_urls').update({ page_key: key }).eq('id', hit.id));
    must(await sb.from('monitored_urls').update({ active: false }).eq('id', hit.id));
    return new Response(null, { status: 204 });
  } catch (e) {
    console.error(e);
    return NextResponse.json({ message: e.message }, { status: 500 });
  }
}
