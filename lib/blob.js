import { put, list } from "@vercel/blob";

const PREFIX = "data/";

function dayFromPathname(pathname) {
  // e.g. "data/2026-09-10.json" -> "2026-09-10"
  const name = pathname.slice(PREFIX.length);
  return name.replace(/\.json$/, "");
}

/** All day keys we have data for, sorted ascending, most recent `limit` kept. */
export async function listDayKeys(limit) {
  const { blobs } = await list({ prefix: PREFIX });
  const days = blobs.map((b) => dayFromPathname(b.pathname)).sort();
  return typeof limit === "number" ? days.slice(-limit) : days;
}

/** Fetch one day's data (object keyed by URL), or {} if nothing recorded. */
export async function getDay(day) {
  const { blobs } = await list({ prefix: `${PREFIX}${day}.json` });
  if (!blobs.length) return {};
  const res = await fetch(blobs[0].url, { cache: "no-store" });
  if (!res.ok) return {};
  try {
    return await res.json();
  } catch {
    return {};
  }
}

/**
 * Merge `results` (object keyed by URL) into the stored data for `day`
 * and write it back. Existing entries for URLs not present in `results`
 * are preserved.
 */
export async function saveDay(day, results) {
  const existing = await getDay(day);
  const merged = { ...existing, ...results };
  await put(`${PREFIX}${day}.json`, JSON.stringify(merged), {
    access: "public",
    addRandomSuffix: false,
    allowOverwrite: true,
    contentType: "application/json",
  });
  return merged;
}
