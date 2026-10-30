import { db, must } from '@/lib/supabase';
import { METRICS, GRADE_RANK, SITE, pageKey, pageName } from '@/lib/pages';
export const dynamic = 'force-dynamic';

// Same shape as the original monitor's data.js: page list + metric schema.
// Scores themselves are loaded live from /api/sb (benchmark_runs).
export async function GET() {
  let pages = [];
  try {
    const urls = must(await db().from('monitored_urls').select('*').eq('active', true).order('sort'));
    pages = urls.map((u) => ({ id: pageKey(u), name: pageName(u), site: u.site || SITE, type: u.page_type, url: u.url }));
  } catch (e) {
    console.error('data.js: ' + e.message);
  }
  const data = { generatedAt: new Date().toISOString(), sample: false, pages, metrics: METRICS, gradeRank: GRADE_RANK, latest: {}, history: [], actionable: null };
  return new Response(`// Generated from Supabase by /api/perf-data (served as /data.js)\nwindow.PERF_DATA = ${JSON.stringify(data)};\n`, {
    headers: { 'content-type': 'application/javascript; charset=utf-8', 'cache-control': 'no-store' },
  });
}
