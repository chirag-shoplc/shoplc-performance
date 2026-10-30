import { NextResponse } from 'next/server';
import { requestRole } from '@/lib/auth';
import { db, must } from '@/lib/supabase';
export const dynamic = 'force-dynamic';

export async function GET(req) {
  const role = await requestRole(req);
  if (!role) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  const sb = db();
  const date = req.nextUrl.searchParams.get('date');

  const urls = must(await sb.from('monitored_urls').select('*').order('sort'));
  const runs = must(await sb.from('runs').select('*').order('created_at', { ascending: false }).limit(200));
  const dates = [...new Set(runs.map((r) => r.run_date))].sort();
  const selected = date || dates[dates.length - 1] || null;

  let results = [];
  if (selected) {
    const rows = must(await sb.from('results').select('*').eq('run_date', selected).order('updated_at', { ascending: true }));
    // keep the latest completed result per page/device for the day (re-runs overwrite earlier ones)
    const latest = new Map();
    for (const r of rows) {
      const k = `${r.url_id || r.url}|${r.page_type}|${r.device}`;
      const prev = latest.get(k);
      if (!prev || r.status === 'completed' || prev.status !== 'completed') latest.set(k, r);
    }
    results = [...latest.values()];
  }

  const active = runs.find((r) => r.status === 'running') || null;
  let activeRows = [];
  if (active) activeRows = must(await sb.from('results').select('id,page_type,url,device,status,error,grade,report_url').eq('run_id', active.id).order('created_at'));

  // day-by-day trend (performance + LCP) for every page, last 60 run days
  const since = dates[Math.max(0, dates.length - 60)];
  const trend = [];
  if (since) {
    for (let from = 0; ; from += 1000) { // Supabase caps a response at 1000 rows — page through
      const page = must(await sb.from('results').select('run_date,url_id,page_type,device,performance,lcp,grade')
        .eq('status', 'completed').gte('run_date', since).order('run_date').order('updated_at').range(from, from + 999));
      trend.push(...page);
      if (page.length < 1000) break;
    }
  }
  const changes = must(await sb.from('url_changes').select('*').order('created_at', { ascending: false }).limit(30));

  return NextResponse.json({ role, urls, runs: runs.slice(0, 15), dates, date: selected, results, active, activeRows, trend, changes });
}
