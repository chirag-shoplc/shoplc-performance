"use client";

import { Fragment, useMemo, useState } from "react";
import {
  ResponsiveContainer,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";
import {
  fmtDay,
  fmtDayLong,
  gradeClass,
  fleetTrend,
  shortPath,
  pageRecord,
  campaignSummaries,
  briefFrom,
  lcpOf,
  tbtOf,
  formatWait,
} from "@/lib/derive";

function ScoreRing({ score, tone, size = 76 }) {
  const r = 30;
  const c = 2 * Math.PI * r;
  const pct = typeof score === "number" ? Math.max(0, Math.min(100, score)) : 0;
  const colors = { good: "#1F6B4A", warn: "#B7811A", bad: "#B4453A", none: "#D4CDC0", pending: "#8A8478" };
  return (
    <svg width={size} height={size} viewBox="0 0 76 76" className="score-ring" aria-hidden>
      <circle cx="38" cy="38" r={r} fill="none" stroke="#EDE6D8" strokeWidth="6" />
      <circle
        cx="38"
        cy="38"
        r={r}
        fill="none"
        stroke={colors[tone] || colors.none}
        strokeWidth="6"
        strokeLinecap="round"
        strokeDasharray={`${(pct / 100) * c} ${c}`}
        transform="rotate(-90 38 38)"
      />
      <text x="38" y="43" textAnchor="middle" className="score-ring-text">
        {typeof score === "number" ? score : "—"}
      </text>
    </svg>
  );
}

function Sparkline({ series }) {
  const w = 96;
  const h = 28;
  const n = Math.max(series.length, 1);
  const bw = w / n;
  const colors = { good: "#1F6B4A", warn: "#B7811A", bad: "#B4453A", pending: "#C9C2B6", none: "#C9C2B6" };
  return (
    <svg width={w} height={h} viewBox={`0 0 ${w} ${h}`} className="spark" aria-label="Score history">
      {series.map((r, i) => {
        const score = typeof r.score === "number" ? r.score : null;
        const bh = score !== null ? Math.max(3, Math.round((score / 100) * h)) : 3;
        const cls = r.status === "done" ? gradeClass(r.grade, r.score) : r.status === "pending" ? "pending" : "bad";
        return (
          <rect
            key={r.date}
            x={(i * bw + 1).toFixed(1)}
            y={h - bh}
            width={Math.max(bw - 2, 1).toFixed(1)}
            height={bh}
            rx="1"
            fill={colors[cls] || colors.none}
          />
        );
      })}
    </svg>
  );
}

function Delta({ value }) {
  if (value === null || value === undefined) return <span className="delta flat">No change yet</span>;
  const cls = value > 0 ? "up" : value < 0 ? "down" : "flat";
  const arrow = value > 0 ? "▲" : value < 0 ? "▼" : "·";
  const label = value === 0 ? "Unchanged" : `${arrow} ${Math.abs(value)} vs first test`;
  return <span className={`delta ${cls}`}>{label}</span>;
}

function HealthPill({ health, grade }) {
  return (
    <span className={`pill ${health.tone}`}>
      {health.label}
      {grade ? <span className="pill-grade">{grade}</span> : null}
    </span>
  );
}

function Metric({ rating, caption }) {
  return (
    <div className="metric">
      <span className={`metric-value ${rating.tone}`}>{rating.value}</span>
      <span className="metric-cap">{caption}</span>
      {rating.label !== "—" && <span className={`metric-tag ${rating.tone}`}>{rating.label}</span>}
    </div>
  );
}

function PageLinks({ url, report }) {
  return (
    <div className="page-links">
      <a href={url} target="_blank" rel="noreferrer">
        Open page
      </a>
      {report ? (
        <a href={report} target="_blank" rel="noreferrer">
          Full test
        </a>
      ) : null}
    </div>
  );
}

function Brief({ brief, dateKeys }) {
  const mix = brief.tested
    ? Math.round((brief.healthy / brief.tested) * 100)
    : 0;

  return (
    <section className="brief">
      <div className="brief-score">
        <ScoreRing score={brief.avg} tone={brief.overall.tone} size={92} />
        <div>
          <div className="eyebrow">Overall page speed</div>
          <h2>{brief.headline}</h2>
          <HealthPill health={brief.overall} />
          {brief.lastDay && (
            <p className="brief-updated">Latest run {fmtDayLong(brief.lastDay)}</p>
          )}
        </div>
      </div>

      <p className="brief-detail">{brief.detail || "Waiting on the first completed test."}</p>

      <div className="mix">
        <div className="mix-track" aria-hidden>
          {brief.healthy > 0 && <span className="seg good" style={{ flex: brief.healthy }} />}
          {brief.fair > 0 && <span className="seg warn" style={{ flex: brief.fair }} />}
          {brief.risk > 0 && <span className="seg bad" style={{ flex: brief.risk }} />}
          {brief.failed > 0 && <span className="seg none" style={{ flex: brief.failed }} />}
        </div>
        <div className="mix-legend">
          <span>
            <i className="dot good" /> {brief.healthy} healthy
          </span>
          <span>
            <i className="dot warn" /> {brief.fair} fair
          </span>
          <span>
            <i className="dot bad" /> {brief.risk} need attention
          </span>
          <span>
            <i className="dot none" /> {brief.failed} failed
          </span>
        </div>
        <p className="mix-note">
          {brief.tested} of {brief.total} pages scored
          {brief.tested ? ` · ${mix}% in healthy range (85+)` : ""}
          {dateKeys.length > 1 ? ` · ${dateKeys.length}-day window` : ""}
        </p>
      </div>
    </section>
  );
}

function Kpis({ brief }) {
  const cards = [
    {
      label: "Need attention",
      value: brief.risk,
      hint: brief.risk ? "Below 65 — slow enough to lose shoppers" : "No pages in the risk range",
      tone: brief.risk ? "bad" : "good",
    },
    {
      label: "Tests failed",
      value: brief.failed,
      hint: brief.failed ? "No score this run — page likely too heavy" : "All tests completed",
      tone: brief.failed ? "bad" : "good",
    },
    {
      label: "Slowest to appear",
      value: brief.slowestAppear ? formatWait(lcpOf(brief.slowestAppear.latest)) : "—",
      hint: brief.slowestAppear ? brief.slowestAppear.label : "No load-time data yet",
      tone: brief.slowestAppear && lcpOf(brief.slowestAppear.latest) > 2500 ? "warn" : "good",
    },
    {
      label: "Best page",
      value: brief.best ? brief.best.latest.score : "—",
      hint: brief.best ? brief.best.label : "No scores yet",
      tone: brief.best ? gradeClass(brief.best.latest.grade, brief.best.latest.score) : "none",
    },
  ];

  return (
    <div className="kpi-row">
      {cards.map((c) => (
        <article key={c.label} className={`kpi tone-${c.tone}`}>
          <div className="label">{c.label}</div>
          <div className="kpi-value">{c.value}</div>
          <div className="kpi-hint">{c.hint}</div>
        </article>
      ))}
    </div>
  );
}

function CampaignGrid({ campaigns, onSelect }) {
  return (
    <section className="campaigns">
      <div className="section-head">
        <h3>By campaign</h3>
        <p>Average score across the pages in each campaign. Weakest campaigns first.</p>
      </div>
      <div className="campaign-grid">
        {campaigns.map((c) => (
          <button type="button" key={c.name} className="campaign-card" onClick={() => onSelect(c.name)}>
            <div className="campaign-top">
              <span className="campaign-name">{c.name}</span>
              <HealthPill health={c.health} />
            </div>
            <div className="campaign-avg">
              {c.avg ?? "—"}
              <span>/ 100</span>
            </div>
            <div className="bar-track">
              <div className={`bar-fill ${c.health.tone}`} style={{ width: `${c.avg || 0}%` }} />
            </div>
            <div className="campaign-meta">
              {c.count} page{c.count === 1 ? "" : "s"}
              {c.atRisk ? ` · ${c.atRisk} need attention` : ""}
              {c.failed ? ` · ${c.failed} failed` : ""}
            </div>
            {c.worst && (
              <div className="campaign-worst">
                Weakest: {c.worst.label.replace(`${c.name} — `, "")} · {c.worst.latest.score}
              </div>
            )}
          </button>
        ))}
      </div>
    </section>
  );
}

function PageRow({ rec }) {
  const score = rec.latest?.score;
  return (
    <tr>
      <td>
        <span className="url-name">{rec.label}</span>
        <span className="url-path">{shortPath(rec.url)}</span>
        {rec.issues.length > 0 && <span className="issue-line">{rec.issues[0]}</span>}
      </td>
      <td className="hide-sm">{rec.group}</td>
      <td>
        <HealthPill health={rec.health} grade={rec.latest?.grade} />
      </td>
      <td>
        <span className="score-plain">{typeof score === "number" ? score : "—"}</span>
      </td>
      <td>
        <Metric rating={rec.lcp} caption="to appear" />
      </td>
      <td className="hide-md">
        <Metric rating={rec.tbt} caption="to tap" />
      </td>
      <td className="hide-md">
        <Sparkline series={rec.series} />
        <div>
          <Delta value={rec.delta} />
        </div>
      </td>
      <td>
        <PageLinks url={rec.url} report={rec.latest?.report_url || rec.today?.report_url} />
      </td>
    </tr>
  );
}

function PagesTable({ records, campaignFilter, setCampaignFilter, campaigns }) {
  const [q, setQ] = useState("");
  const [sort, setSort] = useState("risk");

  const filtered = useMemo(() => {
    const query = q.trim().toLowerCase();
    let list = records.filter((r) => {
      if (campaignFilter && r.group !== campaignFilter) return false;
      if (!query) return true;
      return (
        r.label.toLowerCase().includes(query) ||
        r.group.toLowerCase().includes(query) ||
        r.url.toLowerCase().includes(query)
      );
    });
    if (sort === "risk") {
      const rank = { failed: 0, risk: 1, pending: 2, fair: 3, healthy: 4, none: 5 };
      list = [...list].sort((a, b) => {
        const d = (rank[a.health.key] ?? 9) - (rank[b.health.key] ?? 9);
        if (d) return d;
        return (a.latest?.score ?? 999) - (b.latest?.score ?? 999);
      });
    } else if (sort === "campaign") {
      list = [...list].sort((a, b) => a.group.localeCompare(b.group) || a.label.localeCompare(b.label));
    } else {
      list = [...list].sort((a, b) => a.label.localeCompare(b.label));
    }
    return list;
  }, [records, campaignFilter, q, sort]);

  return (
    <section>
      <div className="section-head">
        <h3>Pages</h3>
        <p>Weakest pages first. “To appear” is how long shoppers wait to see the main content.</p>
      </div>
      <div className="toolbar">
        <input
          type="search"
          placeholder="Search a page or campaign"
          value={q}
          onChange={(e) => setQ(e.target.value)}
          aria-label="Search pages"
        />
        <select value={campaignFilter} onChange={(e) => setCampaignFilter(e.target.value)} aria-label="Filter by campaign">
          <option value="">All campaigns</option>
          {campaigns.map((c) => (
            <option key={c.name} value={c.name}>
              {c.name}
            </option>
          ))}
        </select>
        <select value={sort} onChange={(e) => setSort(e.target.value)} aria-label="Sort pages">
          <option value="risk">Needs attention first</option>
          <option value="campaign">By campaign</option>
          <option value="az">A–Z</option>
        </select>
      </div>
      <div className="table-wrap">
        <table className="overview">
          <thead>
            <tr>
              <th>Page</th>
              <th className="hide-sm">Campaign</th>
              <th>Health</th>
              <th>Score</th>
              <th>Appears in</th>
              <th className="hide-md">Ready to tap</th>
              <th className="hide-md">Trend</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {filtered.length === 0 && (
              <tr>
                <td colSpan={8} className="empty-cell">
                  No pages match that filter.
                </td>
              </tr>
            )}
            {filtered.map((rec) => (
              <PageRow key={rec.url} rec={rec} />
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}

function DayTab({ catalog, dateKeys, days }) {
  const [activeDay, setActiveDay] = useState(dateKeys[dateKeys.length - 1] || null);
  if (!dateKeys.length) {
    return (
      <div className="empty">
        <b>No day-wise reports yet.</b>
        <br />
        Once a daily run is saved, it will show up here.
      </div>
    );
  }
  const day = activeDay && dateKeys.includes(activeDay) ? activeDay : dateKeys[dateKeys.length - 1];
  const dayData = days[day] || {};
  const rows = catalog
    .map((item) => {
      const rec = dayData[item.url];
      if (!rec) return { item, rec: null, health: healthStub("none") };
      const health = healthStub(rec.status === "done" ? gradeClass(rec.grade, rec.score) : rec.status === "pending" ? "pending" : "bad", rec);
      return { item, rec, health };
    })
    .sort((a, b) => {
      const rank = { bad: 0, pending: 1, warn: 2, good: 3, none: 4 };
      const d = (rank[a.health.tone] ?? 9) - (rank[b.health.tone] ?? 9);
      if (d) return d;
      return (a.rec?.score ?? 999) - (b.rec?.score ?? 999);
    });

  return (
    <section>
      <div className="section-head">
        <h3>By day</h3>
        <p>Pick a run date. Pages are ordered by risk for that day.</p>
      </div>
      <div className="daylist">
        {dateKeys.map((d) => (
          <button key={d} className={d === day ? "active" : ""} onClick={() => setActiveDay(d)}>
            {fmtDay(d)}
          </button>
        ))}
      </div>
      <div className="table-wrap">
        <table className="overview">
          <thead>
            <tr>
              <th>Page</th>
              <th>Health</th>
              <th>Score</th>
              <th>Appears in</th>
              <th className="hide-sm">Ready to tap</th>
              <th className="hide-md">Stability</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {rows.map(({ item, rec, health }) => {
              const lcp = rec ? formatWait(lcpOf(rec)) : "—";
              const tbt = rec ? formatWait(tbtOf(rec)) : "—";
              const cls = rec && typeof rec.cls === "number" ? rec.cls.toFixed(2) : "—";
              return (
                <tr key={item.url}>
                  <td>
                    <span className="url-name">{item.label}</span>
                    <span className="url-path">{item.group}</span>
                  </td>
                  <td>
                    <HealthPill health={health} grade={rec?.grade} />
                  </td>
                  <td>
                    <span className="score-plain">{rec?.status === "done" ? rec.score : "—"}</span>
                  </td>
                  <td>{rec?.status === "done" ? lcp : "—"}</td>
                  <td className="hide-sm">{rec?.status === "done" ? tbt : "—"}</td>
                  <td className="hide-md">{rec?.status === "done" ? cls : "—"}</td>
                  <td>
                    <PageLinks url={item.url} report={rec?.report_url} />
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </section>
  );
}

function healthStub(tone, rec) {
  if (!rec) return { key: "none", label: "Not tested", tone: "none" };
  if (rec.status === "error") return { key: "failed", label: "Test failed", tone: "bad" };
  if (rec.status === "pending") return { key: "pending", label: "In progress", tone: "pending" };
  if (tone === "good") return { key: "healthy", label: "Healthy", tone: "good" };
  if (tone === "warn") return { key: "fair", label: "Fair", tone: "warn" };
  return { key: "risk", label: "Needs attention", tone: "bad" };
}

function Trend({ catalog, dateKeys, days }) {
  const trend = useMemo(() => fleetTrend(catalog, dateKeys, days), [catalog, dateKeys, days]);
  if (dateKeys.length < 2) return null;
  return (
    <div className="chart-card">
      <div className="section-head tight">
        <h3>Score over time</h3>
        <p>Average across all pages that completed a test that day.</p>
      </div>
      <ResponsiveContainer width="100%" height={220}>
        <AreaChart data={trend} margin={{ top: 8, right: 12, left: -18, bottom: 0 }}>
          <defs>
            <linearGradient id="scoreFill" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stopColor="#1E3A4C" stopOpacity={0.18} />
              <stop offset="100%" stopColor="#1E3A4C" stopOpacity={0} />
            </linearGradient>
          </defs>
          <CartesianGrid stroke="#E8E1D4" vertical={false} />
          <XAxis dataKey="label" tick={{ fontSize: 12, fill: "#6B645A" }} axisLine={{ stroke: "#E4DDD0" }} tickLine={false} />
          <YAxis domain={[0, 100]} tick={{ fontSize: 12, fill: "#6B645A" }} axisLine={false} tickLine={false} />
          <Tooltip
            formatter={(value) => [value === null ? "no data" : value, "Average score"]}
            contentStyle={{ border: "1px solid #E4DDD0", borderRadius: 12, fontSize: 13, background: "#FFFcf7" }}
          />
          <Area type="monotone" dataKey="average" stroke="#1E3A4C" strokeWidth={2.2} fill="url(#scoreFill)" connectNulls />
        </AreaChart>
      </ResponsiveContainer>
    </div>
  );
}

function Legend() {
  const [open, setOpen] = useState(false);
  return (
    <section className="legend-card">
      <button type="button" className="legend-toggle" onClick={() => setOpen((v) => !v)} aria-expanded={open}>
        What these numbers mean
        <span>{open ? "−" : "+"}</span>
      </button>
      {open && (
        <div className="legend-body">
          <p>
            Scores come from daily GTmetrix checks. A higher score means the page is faster and easier for shoppers to
            use. Slow pages tend to lose sales — especially after about 2–3 seconds of waiting.
          </p>
          <ul>
            <li>
              <b>Healthy (85–100)</b> — loads well; speed is unlikely to cost conversions.
            </li>
            <li>
              <b>Fair (65–84)</b> — shoppers notice the wait. Worth tightening.
            </li>
            <li>
              <b>Needs attention (below 65)</b> — slow enough to lose impatient shoppers.
            </li>
            <li>
              <b>Appears in</b> — time until the main content shows (product, hero, headline).
            </li>
            <li>
              <b>Ready to tap</b> — extra delay before buttons and links respond.
            </li>
            <li>
              <b>Stability</b> — whether the page jumps around while loading (lower is better).
            </li>
          </ul>
        </div>
      )}
    </section>
  );
}

export default function Dashboard({ dateKeys, days, catalog, error }) {
  const [tab, setTab] = useState("overview");
  const [campaignFilter, setCampaignFilter] = useState("");

  const records = useMemo(
    () => catalog.map((item) => pageRecord(item, dateKeys, days)),
    [catalog, dateKeys, days],
  );
  const campaigns = useMemo(() => campaignSummaries(records), [records]);
  const brief = useMemo(() => briefFrom(records, dateKeys), [records, dateKeys]);

  return (
    <div className="wrap">
      <header className="top">
        <div>
          <p className="brand">ShopLC</p>
          <h1>Campaign page speed</h1>
          <p className="sub">
            How quickly shoppers can see and use {catalog.length} campaign pages — scored daily, written in plain
            language.
          </p>
        </div>
        <div className="meta">
          <div className="meta-k">{dateKeys.length ? fmtDayLong(dateKeys[dateKeys.length - 1]) : "No data yet"}</div>
          <div className="meta-v">{catalog.length} pages tracked</div>
        </div>
      </header>

      {error && (
        <div className="empty">
          <b>Could not load data.</b>
          <br />
          {error}
        </div>
      )}

      {!error && dateKeys.length === 0 && (
        <div className="empty">
          <b>No results yet.</b>
          <br />
          After the first daily run is saved, this briefing will fill in automatically.
        </div>
      )}

      {!error && dateKeys.length > 0 && (
        <>
          <Brief brief={brief} dateKeys={dateKeys} />
          <Kpis brief={brief} />
          <Trend catalog={catalog} dateKeys={dateKeys} days={days} />

          <nav className="tabs">
            <button className={tab === "overview" ? "active" : ""} onClick={() => setTab("overview")}>
              Overview
            </button>
            <button className={tab === "day" ? "active" : ""} onClick={() => setTab("day")}>
              By day
            </button>
          </nav>

          {tab === "overview" ? (
            <Fragment>
              <CampaignGrid
                campaigns={campaigns}
                onSelect={(name) => {
                  setCampaignFilter(name);
                  document.getElementById("pages")?.scrollIntoView({ behavior: "smooth", block: "start" });
                }}
              />
              <div id="pages">
                <PagesTable
                  records={records}
                  campaignFilter={campaignFilter}
                  setCampaignFilter={setCampaignFilter}
                  campaigns={campaigns}
                />
              </div>
            </Fragment>
          ) : (
            <DayTab catalog={catalog} dateKeys={dateKeys} days={days} />
          )}

          <Legend />
        </>
      )}

      <footer className="foot">
        <span>Higher scores mean faster pages for shoppers. Read-only — no login needed.</span>
        <span>
          Healthy 85+ · Fair 65–84 · Needs attention below 65
        </span>
      </footer>
    </div>
  );
}
