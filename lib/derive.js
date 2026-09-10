const MONTHS_SHORT = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
const MONTHS_LONG = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

function parseDay(k) {
  const [y, m, d] = k.split("-").map(Number);
  return { y, m, d };
}

export function fmtDay(k) {
  const { m, d } = parseDay(k);
  return `${MONTHS_SHORT[m - 1]} ${d}`;
}

export function fmtDayLong(k) {
  const { y, m, d } = parseDay(k);
  return `${MONTHS_LONG[m - 1]} ${d}, ${y}`;
}

export function seriesFor(url, dateKeys, days) {
  return dateKeys
    .map((d) => (days[d] && days[d][url] ? { date: d, ...days[d][url] } : null))
    .filter(Boolean);
}

export function latestFor(url, dateKeys, days) {
  const s = seriesFor(url, dateKeys, days).filter((r) => r.status === "done");
  return s.length ? s[s.length - 1] : null;
}

export function firstFor(url, dateKeys, days) {
  const s = seriesFor(url, dateKeys, days).filter((r) => r.status === "done");
  return s.length ? s[0] : null;
}

export function gradeClass(grade, score) {
  if (typeof score === "number") {
    if (score >= 85) return "good";
    if (score >= 65) return "warn";
    return "bad";
  }
  if (!grade) return "none";
  const g = grade[0].toUpperCase();
  if (g === "A" || g === "B") return "good";
  if (g === "C") return "warn";
  return "bad";
}

/** One point per day: the average "done" score across the whole catalog that day. */
export function fleetTrend(catalog, dateKeys, days) {
  return dateKeys.map((d) => {
    const scores = catalog
      .map((c) => days[d] && days[d][c.url])
      .filter((r) => r && r.status === "done" && typeof r.score === "number")
      .map((r) => r.score);
    const avg = scores.length ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length) : null;
    return { date: d, label: fmtDay(d), average: avg, tested: scores.length };
  });
}

export function fleetAverage(catalog, pick) {
  const scores = catalog.map((c) => pick(c.url)).filter((v) => typeof v === "number");
  if (!scores.length) return null;
  return Math.round(scores.reduce((a, b) => a + b, 0) / scores.length);
}

export function healthOf(score, status) {
  if (status === "error") return { key: "failed", label: "Test failed", tone: "bad" };
  if (status === "pending") return { key: "pending", label: "In progress", tone: "pending" };
  if (typeof score !== "number") return { key: "none", label: "Not tested", tone: "none" };
  if (score >= 85) return { key: "healthy", label: "Healthy", tone: "good" };
  if (score >= 65) return { key: "fair", label: "Fair", tone: "warn" };
  return { key: "risk", label: "Needs attention", tone: "bad" };
}

function num(v) {
  return typeof v === "number" ? v : null;
}

export function lcpOf(rec) {
  if (!rec) return null;
  return num(rec.lcp_ms ?? rec.lcp);
}

export function tbtOf(rec) {
  if (!rec) return null;
  return num(rec.tbt_ms ?? rec.tbt);
}

export function formatWait(ms) {
  if (typeof ms !== "number") return "—";
  if (ms >= 1000) return `${(ms / 1000).toFixed(1)}s`;
  return `${Math.round(ms)}ms`;
}

export function lcpRating(ms) {
  if (typeof ms !== "number") return { key: "none", label: "—", value: "—", tone: "none" };
  const value = formatWait(ms);
  if (ms <= 2500) return { key: "good", label: "Fast", value, tone: "good" };
  if (ms <= 4000) return { key: "warn", label: "Slow", value, tone: "warn" };
  return { key: "bad", label: "Very slow", value, tone: "bad" };
}

export function clsRating(cls) {
  if (typeof cls !== "number") return { key: "none", label: "—", value: "—", tone: "none" };
  const value = cls.toFixed(2);
  if (cls <= 0.1) return { key: "good", label: "Stable", value, tone: "good" };
  if (cls <= 0.25) return { key: "warn", label: "Shifts", value, tone: "warn" };
  return { key: "bad", label: "Jumps", value, tone: "bad" };
}

export function tbtRating(ms) {
  if (typeof ms !== "number") return { key: "none", label: "—", value: "—", tone: "none" };
  const value = formatWait(ms);
  if (ms <= 200) return { key: "good", label: "Snappy", value, tone: "good" };
  if (ms <= 600) return { key: "warn", label: "Delayed", value, tone: "warn" };
  return { key: "bad", label: "Sluggish", value, tone: "bad" };
}

export function issuesFor(rec) {
  if (!rec) return [];
  if (rec.status === "error") {
    return [rec.message ? `Could not test: ${rec.message}` : "This page failed to test"];
  }
  if (rec.status !== "done") return [];
  const issues = [];
  const lcp = lcpOf(rec);
  const tbt = tbtOf(rec);
  if (typeof lcp === "number" && lcp > 2500) {
    issues.push(`Main content takes ${formatWait(lcp)} to appear`);
  }
  if (typeof rec.cls === "number" && rec.cls > 0.1) {
    issues.push("The layout shifts while loading");
  }
  if (typeof tbt === "number" && tbt > 600) {
    issues.push(`Shoppers wait ${formatWait(tbt)} before they can tap`);
  }
  return issues;
}

export function shortPath(url) {
  try {
    const u = new URL(url);
    return `${u.pathname}${u.search}`;
  } catch {
    return url;
  }
}

export function pageRecord(item, dateKeys, days) {
  const latest = latestFor(item.url, dateKeys, days);
  const first = firstFor(item.url, dateKeys, days);
  const lastKey = dateKeys[dateKeys.length - 1];
  const today = lastKey ? days[lastKey]?.[item.url] : null;
  const series = seriesFor(item.url, dateKeys, days);
  const delta =
    latest && first && first.date !== latest.date && typeof latest.score === "number" && typeof first.score === "number"
      ? latest.score - first.score
      : null;
  const status = today?.status || latest?.status;
  const health = healthOf(latest?.score, status);
  const rec = today?.status === "error" ? today : latest || today;
  return {
    ...item,
    latest,
    first,
    today,
    series,
    delta,
    health,
    issues: issuesFor(rec),
    lcp: lcpRating(lcpOf(latest)),
    cls: clsRating(typeof latest?.cls === "number" ? latest.cls : null),
    tbt: tbtRating(tbtOf(latest)),
  };
}

export function campaignSummaries(records) {
  const groups = [];
  const seen = new Set();
  for (const r of records) {
    if (seen.has(r.group)) continue;
    seen.add(r.group);
    const pages = records.filter((p) => p.group === r.group);
    const scores = pages.map((p) => p.latest?.score).filter((v) => typeof v === "number");
    const avg = scores.length ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length) : null;
    const failed = pages.filter((p) => p.today?.status === "error" || p.health.key === "failed").length;
    const atRisk = pages.filter((p) => p.health.key === "risk").length;
    const worst = pages
      .filter((p) => typeof p.latest?.score === "number")
      .sort((a, b) => a.latest.score - b.latest.score)[0];
    const health =
      avg === null && failed ? healthOf(null, "error") : healthOf(avg, "done");
    groups.push({
      name: r.group,
      pages,
      count: pages.length,
      avg,
      failed,
      atRisk,
      worst,
      health,
    });
  }
  return groups.sort((a, b) => (a.avg ?? 999) - (b.avg ?? 999));
}

export function briefFrom(records, dateKeys) {
  const tested = records.filter((r) => r.latest);
  const failed = records.filter((r) => r.today?.status === "error" || r.health.key === "failed");
  const healthy = tested.filter((r) => r.health.key === "healthy");
  const fair = tested.filter((r) => r.health.key === "fair");
  const risk = tested.filter((r) => r.health.key === "risk");
  const scores = tested.map((r) => r.latest.score).filter((v) => typeof v === "number");
  const avg = scores.length ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length) : null;
  const overall = failed.length && !tested.length ? healthOf(null, "error") : healthOf(avg, "done");

  const slowestAppear = tested
    .filter((r) => typeof lcpOf(r.latest) === "number")
    .sort((a, b) => lcpOf(b.latest) - lcpOf(a.latest))[0];
  const slowestTap = tested
    .filter((r) => typeof tbtOf(r.latest) === "number")
    .sort((a, b) => tbtOf(b.latest) - tbtOf(a.latest))[0];
  const best = tested
    .filter((r) => typeof r.latest?.score === "number")
    .sort((a, b) => b.latest.score - a.latest.score)[0];

  let headline;
  if (!tested.length && failed.length) headline = "Tests did not complete";
  else if (!tested.length) headline = "No scores yet";
  else if (risk.length || failed.length) headline = "Page speed needs attention";
  else if (fair.length) headline = "Page speed is fair — room to convert more";
  else headline = "Campaign pages are loading well";

  const parts = [];
  if (tested.length) {
    parts.push(`${risk.length} of ${tested.length} pages scored below a healthy range`);
  }
  if (failed.length) parts.push(`${failed.length} page${failed.length === 1 ? "" : "s"} failed to test`);
  if (slowestAppear && lcpOf(slowestAppear.latest) > 2500) {
    parts.push(`slowest to appear: ${slowestAppear.label} (${formatWait(lcpOf(slowestAppear.latest))})`);
  }
  if (slowestTap && tbtOf(slowestTap.latest) > 1000) {
    parts.push(`longest wait to tap: ${slowestTap.label} (${formatWait(tbtOf(slowestTap.latest))})`);
  }

  return {
    avg,
    overall,
    tested: tested.length,
    total: records.length,
    healthy: healthy.length,
    fair: fair.length,
    risk: risk.length,
    failed: failed.length,
    headline,
    detail: parts.join(" · "),
    best,
    slowestAppear,
    slowestTap,
    lastDay: dateKeys.length ? dateKeys[dateKeys.length - 1] : null,
    firstDay: dateKeys.length ? dateKeys[0] : null,
  };
}
