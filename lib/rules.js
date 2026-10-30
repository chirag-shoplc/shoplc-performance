// Thresholds + rule engine (shared by server and client).
// Values mirror the original VGL monitor's schema (good / acceptable / needs).
// Stored units: times in ms, size in bytes. <= good is green, <= poor is amber, > poor is red.
const MB = 1048576;
export const METRICS = [
  { key: 'performance', label: 'Performance Score', unit: '%', higher: true, good: 90, ok: 80, poor: 50,
    title: 'Lift GTmetrix Performance score', advice: 'Driven by the metrics below — fixing LCP, TBT & Speed Index moves this most.' },
  { key: 'structure', label: 'Structure Score', unit: '%', higher: true, good: 90, ok: 80, poor: 60,
    title: 'Improve GTmetrix Structure score', advice: 'Work through the GTmetrix Structure audits: unused JS/CSS, image sizing, caching and render-blocking resources.' },
  { key: 'lcp', label: 'Largest Contentful Paint', unit: 's', good: 1200, ok: 2500, poor: 4000,
    title: 'Speed up Largest Contentful Paint', advice: 'Preload the hero image, serve it in AVIF/WebP at the right size, and avoid lazy-loading it.' },
  { key: 'fcp', label: 'First Contentful Paint', unit: 's', good: 900, ok: 1600, poor: 2500,
    title: 'Speed up First Contentful Paint', advice: 'Inline critical CSS, defer non-critical JS, and reduce server response (TTFB).' },
  { key: 'speed_index', label: 'Speed Index', unit: 's', good: 1300, ok: 2900, poor: 4200,
    title: 'Improve Speed Index', advice: 'Prioritise above-the-fold content; lazy-load below-the-fold media and third-party embeds.' },
  { key: 'tbt', label: 'Total Blocking Time', unit: 'ms', good: 150, ok: 350, poor: 600,
    title: 'Cut Total Blocking Time', advice: 'Break up / defer long JS tasks, remove unused scripts, and load tags via a tag manager after load.' },
  { key: 'cls', label: 'Cumulative Layout Shift', unit: '', good: 0.1, ok: 0.25, poor: 0.4,
    title: 'Reduce Cumulative Layout Shift', advice: 'Set explicit width/height on images & ad slots, and reserve space for banners/fonts.' },
  { key: 'tti', label: 'Time to Interactive', unit: 's', good: 2500, ok: 3800, poor: 7300,
    title: 'Reduce Time to Interactive', advice: 'Ship less JS on first load (code-split), defer analytics, and hydrate lazily.' },
  { key: 'fully_loaded', label: 'Fully Loaded Time', unit: 's', good: 3000, ok: 5000, poor: 8000,
    title: 'Reduce Fully Loaded Time', advice: 'Lazy-load below-the-fold assets and trim third-party requests firing after load.' },
  { key: 'page_bytes', label: 'Total Page Size', unit: 'MB', good: 1 * MB, ok: 2 * MB, poor: 4 * MB,
    title: 'Reduce total page weight', advice: 'Compress & modern-format images, minify CSS/JS, and drop unused fonts/libraries.' },
  { key: 'page_requests', label: 'Total Requests', unit: '', good: 40, ok: 75, poor: 100,
    title: 'Reduce number of requests', advice: 'Bundle assets, remove redundant third-party tags, and use sprites/icon fonts.' },
];

export function fmt(m, v) {
  if (v == null || v === '') return '—';
  v = Number(v);
  if (m.unit === 's') return (v / 1000).toFixed(2) + 's';
  if (m.unit === 'ms') return Math.round(v) + 'ms';
  if (m.unit === 'MB') return (v / MB).toFixed(2) + 'MB';
  if (m.unit === '%') return Math.round(v) + '%';
  if (m.key === 'cls') return v.toFixed(3);
  return String(Math.round(v));
}

export function fmtTarget(m) {
  return (m.higher ? '≥ ' : '≤ ') + (m.key === 'cls' ? m.good.toFixed(3) : fmt(m, m.good));
}

const worse = (m, a, b) => (m.higher ? a < b : a > b);

/** 'good' | 'ok' | 'poor' | null  (ok = amber band) */
export function band(m, v) {
  if (v == null) return null;
  v = Number(v);
  if (!worse(m, v, m.good)) return 'good';
  if (!worse(m, v, m.poor)) return 'ok';
  return 'poor';
}

/** CRITICAL (worse than poor) | HIGH (worse than acceptable) | MEDIUM (short of good) | null */
export function severity(m, v) {
  if (v == null) return null;
  v = Number(v);
  if (worse(m, v, m.poor)) return 'CRITICAL';
  if (worse(m, v, m.ok)) return 'HIGH';
  if (worse(m, v, m.good)) return 'MEDIUM';
  return null;
}

export function gradeBand(g) {
  if (!g) return null;
  return 'AB'.includes(g[0]) ? 'good' : 'CD'.includes(g[0]) ? 'ok' : 'poor';
}

const SEV_RANK = { CRITICAL: 3, HIGH: 2, MEDIUM: 1 };

/** Ranked actions for one page given { desktop, mobile } result rows. Mobile weighted first. */
export function actionsFor(byDevice, limit = 4) {
  const items = [];
  for (const device of ['mobile', 'desktop']) {
    const r = byDevice[device];
    if (!r || r.status !== 'completed') continue;
    for (const m of METRICS) {
      if (m.key === 'structure') continue; // GTmetrix grade input, not a dev target on its own
      const sev = severity(m, r[m.key]);
      if (!sev) continue;
      const raw = m.higher ? (m.good - r[m.key]) / m.good : (r[m.key] - m.good) / m.good;
      items.push({ m, device, sev, value: r[m.key], gap: raw * (device === 'mobile' ? 1.25 : 1) });
    }
  }
  items.sort((a, b) => SEV_RANK[b.sev] - SEV_RANK[a.sev] || b.gap - a.gap);
  return { top: items.slice(0, limit), total: items.length };
}
