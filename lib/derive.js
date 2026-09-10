export function fmtDay(k) {
  const [y, m, d] = k.split("-").map(Number);
  const dt = new Date(y, m - 1, d);
  return dt.toLocaleDateString(undefined, { month: "short", day: "numeric" });
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
