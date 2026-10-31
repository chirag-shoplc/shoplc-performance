const BASE = 'https://gtmetrix.com/api/2.0';

function headers() {
  const key = process.env.GTMETRIX_API_KEY;
  if (!key) throw new Error('GTMETRIX_API_KEY not set');
  return {
    Authorization: 'Basic ' + Buffer.from(`${key}:`).toString('base64'),
    'Content-Type': 'application/vnd.api+json',
  };
}

export class GtmetrixError extends Error {
  constructor(msg, status) { super(msg); this.status = status; }
}

async function call(path, init = {}) {
  const res = await fetch(BASE + path, { ...init, headers: headers(), cache: 'no-store' });
  const json = await res.json().catch(() => ({}));
  if (!res.ok) {
    const detail = json?.errors?.[0]?.detail || json?.errors?.[0]?.title || res.statusText;
    throw new GtmetrixError(`GTmetrix ${res.status}: ${detail}`, res.status);
  }
  return json;
}

export async function startTest({ url, device, location }) {
  const attributes = {
    url,
    location: await resolveLocation(location || process.env.GTMETRIX_LOCATION || 'Chicago'),
    browser: String(process.env.GTMETRIX_BROWSER || '3'),
  };
  if (process.env.GTMETRIX_RETENTION) attributes.retention = String(process.env.GTMETRIX_RETENTION); // months the report link stays live
  if (device === 'mobile') {
    if (process.env.GTMETRIX_MOBILE_DEVICE) {
      attributes.simulate_device = process.env.GTMETRIX_MOBILE_DEVICE;
    } else {
      attributes.browser_width = 390;
      attributes.browser_height = 844;
      attributes.browser_dppx = 3;
      attributes.throttle = '9000/1500/150'; // ~4G: down/up Kbps, latency ms
    }
  }
  const json = await call('/tests', {
    method: 'POST',
    body: JSON.stringify({ data: { type: 'test', attributes } }),
  });
  return { testId: json.data.id, creditsLeft: json.meta?.credits_left };
}

/** Returns { state: 'queued'|'started'|'completed'|'error', report?, error? } */
export async function checkTest(testId) {
  const json = await call(`/tests/${testId}`); // completed tests 303-redirect to the report
  const d = json.data;
  if (d?.type === 'report') return { state: 'completed', report: d };
  const a = d?.attributes || {};
  if (a.state === 'error') return { state: 'error', error: a.error || 'GTmetrix test error' };
  if (a.state === 'completed' && d?.links?.report) {
    const id = d.links.report.split('/').pop();
    const rep = await call(`/reports/${id}`);
    return { state: 'completed', report: rep.data };
  }
  return { state: a.state || 'queued' };
}

export function reportToMetrics(report) {
  const a = report.attributes || {};
  return {
    grade: a.gtmetrix_grade ?? null,
    performance: a.performance_score ?? null,
    structure: a.structure_score ?? null,
    fcp: a.first_contentful_paint ?? null,
    lcp: a.largest_contentful_paint ?? null,
    tbt: a.total_blocking_time ?? null,
    cls: a.cumulative_layout_shift ?? null,
    speed_index: a.speed_index ?? null,
    tti: a.time_to_interactive ?? null,
    fully_loaded: a.fully_loaded_time ?? null,
    page_bytes: a.page_bytes ?? null,
    page_requests: a.page_requests ?? null,
    report_url: report.links?.report_url || null,
  };
}

/** Accepts a GTmetrix location id ("4") or a city name ("Chicago") and returns the id. */
export async function resolveLocation(value) {
  const v = String(value).trim();
  if (/^\d+$/.test(v)) return v;
  const locs = await listLocations();
  const hit = locs.find((l) => l.name.toLowerCase().includes(v.toLowerCase().split(',')[0]));
  if (!hit) throw new Error(`GTmetrix location "${v}" not found on this account`);
  return hit.id;
}

/** Account status: API credits left and when they refill. */
export async function accountStatus() {
  const json = await call('/status');
  const a = json.data?.attributes || {};
  return { credits: a.api_credits ?? null, refill: a.api_refill ? new Date(a.api_refill * 1000).toISOString() : null };
}

let locCache;
export async function listLocations() {
  if (locCache) return locCache;
  const json = await call('/locations');
  locCache = (json.data || []).map((l) => ({ id: l.id, name: l.attributes?.name || l.id }));
  return locCache;
}
