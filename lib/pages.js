// Page identity shared with the original VGL monitor (page keys + display names).
export const SITE = 'Shop LC';
const BY_TYPE = {
  'Home':                 { key: 'slc_home',     name: 'Shop LC — Home' },
  'Product / PDP':        { key: 'slc_pdp',      name: 'Shop LC — Tourmaline Ring (PDP)' },
  'Category / PLP':       { key: 'slc_plp',      name: 'Shop LC — Certified Jewelry (PLP)' },
  'RA Auction / PLP':     { key: 'slc_ra_plp',   name: 'Shop LC — RA Auctions (PLP)' },
  'RA Auction / Landing': { key: 'slc_ra_lp',    name: 'Shop LC — RA Auctions Landing' },
  'RA Auction / PDP':     { key: 'slc_ra_pdp',   name: 'Shop LC — RA Auction (PDP)' },
  'Funnel / Cart':        { key: 'slc_cart',     name: 'Shop LC — Cart' },
  'Funnel / Checkout':    { key: 'slc_checkout', name: 'Shop LC — Checkout' },
};
export const FUNNEL_TYPES = new Set(['Funnel / Cart', 'Funnel / Checkout']);

export function pageKey(u) {
  if (u.page_key) return u.page_key;
  return BY_TYPE[u.page_type]?.key || 'slc_' + String(u.page_type || 'page').toLowerCase().replace(/[^a-z0-9]+/g, '_').replace(/^_|_$/g, '');
}
export function pageName(u) {
  return u.name || BY_TYPE[u.page_type]?.name || `${SITE} — ${u.page_type}`;
}

// Thresholds/metric schema exactly as the original monitor's data.js
export const METRICS = [
  { key: 'grade', label: 'GTmetrix Grade', unit: '', kind: 'grade' },
  { key: 'performance', label: 'Performance Score', unit: '%', kind: 'higher', good: 90, acceptable: 80, needs: 50, decimals: 0 },
  { key: 'structure', label: 'Structure Score', unit: '%', kind: 'higher', good: 90, acceptable: 80, needs: 60, decimals: 0 },
  { key: 'lcp', label: 'Largest Contentful Paint', unit: 's', kind: 'lower', good: 1.2, acceptable: 2.5, needs: 4, decimals: 2 },
  { key: 'fcp', label: 'First Contentful Paint', unit: 's', kind: 'lower', good: 0.9, acceptable: 1.6, needs: 2.5, decimals: 2 },
  { key: 'si', label: 'Speed Index', unit: 's', kind: 'lower', good: 1.3, acceptable: 2.9, needs: 4.2, decimals: 2 },
  { key: 'tbt', label: 'Total Blocking Time', unit: 'ms', kind: 'lower', good: 150, acceptable: 350, needs: 600, decimals: 0 },
  { key: 'cls', label: 'Cumulative Layout Shift', unit: '', kind: 'lower', good: 0.1, acceptable: 0.25, needs: 0.4, decimals: 3 },
  { key: 'tti', label: 'Time to Interactive', unit: 's', kind: 'lower', good: 2.5, acceptable: 3.8, needs: 7.3, decimals: 2 },
  { key: 'fully', label: 'Fully Loaded Time', unit: 's', kind: 'lower', good: 3, acceptable: 5, needs: 8, decimals: 2 },
  { key: 'pagesize', label: 'Total Page Size', unit: 'MB', kind: 'lower', good: 1, acceptable: 2, needs: 4, decimals: 2 },
  { key: 'requests', label: 'Total Requests', unit: '', kind: 'lower', good: 40, acceptable: 75, needs: 100, decimals: 0 },
];
export const GRADE_RANK = { A: 4, B: 3, C: 2, D: 1, E: 0, F: 0 };

const MB = 1048576;
const s = (ms) => (ms == null ? null : Math.round(Number(ms)) / 1000);
const n = (v) => (v == null ? null : Number(v));
/** results row (ms / bytes) -> original monitor row (seconds / MB) */
export function toMonitorRow(r, key) {
  return {
    run_date: r.run_date, page_key: key, device: r.device,
    grade: r.grade ?? null, performance: n(r.performance), structure: n(r.structure),
    lcp: s(r.lcp), fcp: s(r.fcp), si: s(r.speed_index), tbt: n(r.tbt), cls: n(r.cls),
    tti: s(r.tti), fully: s(r.fully_loaded),
    pagesize: r.page_bytes == null ? null : Math.round((Number(r.page_bytes) / MB) * 100) / 100,
    requests: n(r.page_requests), report_url: r.report_url || null, generated_at: r.updated_at,
    resolved_url: r.resolved_url || null, resolved_label: r.resolved_label || null,
  };
}
