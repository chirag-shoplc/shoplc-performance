// Builds supabase/seed_history.sql from the original VGL monitor's Shop LC data
// (60 days of Performance + LCP history, plus the full metric set for the latest run).
import { readFileSync, writeFileSync } from 'fs';
const here = new URL('.', import.meta.url);
const TYPE = { home: 'Home', pdp: 'Product / PDP', plp: 'Category / PLP', ra_plp: 'RA Auction / PLP', ra_lp: 'RA Auction / Landing', ra_pdp: 'RA Auction / PDP', cart: 'Funnel / Cart', checkout: 'Funnel / Checkout' };
const MB = 1048576, ms = (s) => (s === '' || s == null ? null : Math.round(Number(s) * 1000));
const n = (v) => (v === '' || v == null ? null : Number(v));
const rows = new Map(); // key date|page|device -> metrics
const put = (date, page, device, m) => {
  const k = `${date}|${page}|${device}`;
  rows.set(k, { ...(rows.get(k) || {}), ...m });
};
for (const line of readFileSync(new URL('history.txt', here), 'utf8').trim().split('\n')) {
  const [md, rest] = line.split('|');
  for (const part of rest.split(';')) {
    const [p, dp, dl, mp, ml] = part.split(',');
    if (dp !== '') put(`2026-${md}`, p, 'desktop', { performance: n(dp), lcp: ms(dl) });
    if (mp !== '') put(`2026-${md}`, p, 'mobile', { performance: n(mp), lcp: ms(ml) });
  }
}
for (const line of readFileSync(new URL('latest.txt', here), 'utf8').trim().split('\n')) {
  const [md, rest] = line.split('|');
  const [p, d, grade, perf, struct, lcp, fcp, si, tbt, cls, tti, fully, size, req] = rest.split(',');
  put(`2026-${md}`, p, d === 'd' ? 'desktop' : 'mobile', {
    grade, performance: n(perf), structure: n(struct), lcp: ms(lcp), fcp: ms(fcp), speed_index: ms(si),
    tbt: n(tbt), cls: n(cls), tti: ms(tti), fully_loaded: ms(fully), page_bytes: Math.round(n(size) * MB), page_requests: n(req),
  });
}
const dates = [...new Set([...rows.keys()].map((k) => k.split('|')[0]))].sort();
const q = (v) => (v == null ? 'null' : typeof v === 'number' ? String(v) : `'${String(v).replace(/'/g, "''")}'`);
const cols = ['grade', 'performance', 'structure', 'lcp', 'fcp', 'speed_index', 'tbt', 'cls', 'tti', 'fully_loaded', 'page_bytes', 'page_requests'];
let sql = `-- OPTIONAL: imports Shop LC history from the original VGL monitor (${dates[0]} → ${dates.at(-1)}).
-- Run AFTER schema.sql. Older days carry Performance + LCP only (that is all the original kept); the latest run has every metric.
begin;\n`;
for (const date of dates) {
  sql += `\nwith r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('${date}', 'import', 'done', '${date}T05:00:00Z', '${date}T05:30:00Z') returning id)\n`;
  sql += `insert into results (run_id, url_id, run_date, page_type, url, device, location, status, ${cols.join(', ')}, created_at, updated_at)\nselect r.id, u.id, '${date}', u.page_type, u.url, v.device, u.location, 'completed', ${cols.map((c) => 'v.' + c).join(', ')}, '${date}T05:30:00Z', '${date}T05:30:00Z'\nfrom r, (values\n`;
  const vals = [...rows.entries()].filter(([k]) => k.startsWith(date)).map(([k, m]) => {
    const [, p, device] = k.split('|');
    return `  (${q(TYPE[p])}, ${q(device)}, ${cols.map((c) => q(m[c] ?? null) + (c === 'grade' ? '::text' : '::numeric')).join(', ')})`;
  });
  sql += vals.join(',\n') + `\n) as v(page_type, device, ${cols.join(', ')})\njoin monitored_urls u on u.page_type = v.page_type;\n`;
}
sql += '\ncommit;\n';
writeFileSync(new URL('../supabase/seed_history.sql', here), sql);
console.log(`${dates.length} days, ${rows.size} results`);
