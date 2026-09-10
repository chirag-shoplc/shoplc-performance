"use client";

import { useMemo, useState } from "react";
import {
  ResponsiveContainer,
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";
import {
  fmtDay,
  seriesFor,
  latestFor,
  firstFor,
  gradeClass,
  fleetTrend,
  fleetAverage,
} from "@/lib/derive";

function Sparkline({ url, dateKeys, days }) {
  const series = seriesFor(url, dateKeys, days);
  const w = 110;
  const h = 26;
  const n = Math.max(series.length, 1);
  const bw = w / n;
  const colors = { good: "#2F6B4F", warn: "#8A5A15", bad: "#8C3B2E", pending: "#B9B6A8", none: "#B9B6A8" };
  return (
    <svg width={w} height={h} viewBox={`0 0 ${w} ${h}`}>
      {series.map((r, i) => {
        const score = typeof r.score === "number" ? r.score : null;
        const bh = score !== null ? Math.max(2, Math.round((score / 100) * h)) : 3;
        const y = h - bh;
        const cls = r.status === "done" ? gradeClass(r.grade, r.score) : r.status === "pending" ? "pending" : "bad";
        return (
          <rect
            key={r.date}
            x={(i * bw + 1).toFixed(1)}
            y={y}
            width={Math.max(bw - 2, 1).toFixed(1)}
            height={bh}
            fill={colors[cls] || colors.none}
          />
        );
      })}
    </svg>
  );
}

function StatusPill({ url, dateKeys, days }) {
  const today = days[dateKeys[dateKeys.length - 1]]?.[url];
  const latest = latestFor(url, dateKeys, days);
  if (today && today.status === "pending") return <span className="pill pending">pending</span>;
  if (today && today.status === "error") return <span className="pill bad">error</span>;
  if (!latest) return <span className="pill none">not tested</span>;
  const cls = gradeClass(latest.grade, latest.score);
  return (
    <span className={`pill ${cls}`}>
      {latest.score} · {latest.grade || "—"}
    </span>
  );
}

function DeltaCell({ url, dateKeys, days }) {
  const first = firstFor(url, dateKeys, days);
  const latest = latestFor(url, dateKeys, days);
  if (!first || !latest || first.date === latest.date) {
    return <span className="delta-cell" style={{ color: "var(--ink-soft)" }}>—</span>;
  }
  const d = latest.score - first.score;
  const cls = d > 0 ? "up" : d < 0 ? "down" : "flat";
  const arrow = d > 0 ? "▲" : d < 0 ? "▼" : "·";
  return (
    <span className={`delta-cell delta ${cls}`}>
      {arrow} {Math.abs(d)}
    </span>
  );
}

function SummaryAndTrend({ catalog, dateKeys, days }) {
  const todayAvg = fleetAverage(catalog, (u) => {
    const l = latestFor(u, dateKeys, days);
    return l ? l.score : null;
  });
  const earliestAvg = fleetAverage(catalog, (u) => {
    const f = firstFor(u, dateKeys, days);
    return f ? f.score : null;
  });
  const tested = catalog.filter((c) => latestFor(c.url, dateKeys, days)).length;
  const trend = useMemo(() => fleetTrend(catalog, dateKeys, days), [catalog, dateKeys, days]);

  let deltaEl = <span className="delta flat">no baseline yet</span>;
  if (todayAvg !== null && earliestAvg !== null) {
    const d = todayAvg - earliestAvg;
    const cls = d > 0 ? "up" : d < 0 ? "down" : "flat";
    const arrow = d > 0 ? "▲" : d < 0 ? "▼" : "·";
    deltaEl = (
      <span className={`delta ${cls}`}>
        {arrow} {Math.abs(d)} pts vs {dateKeys.length ? fmtDay(dateKeys[0]) : "start"}
      </span>
    );
  }

  return (
    <>
      <div className="summary-row">
        <div className="summary-card">
          <div className="label">Fleet average score</div>
          <div className="big">
            {todayAvg !== null ? todayAvg : "—"}
            <span style={{ fontSize: 16, color: "var(--ink-soft)" }}> / 100</span>
          </div>
          <div className="bar-track">
            <div className="bar-fill" style={{ width: `${todayAvg || 0}%` }} />
          </div>
          <div>{deltaEl}</div>
        </div>
        <div className="summary-card">
          <div className="label">Coverage</div>
          <div className="big">
            {tested}
            <span style={{ fontSize: 16, color: "var(--ink-soft)" }}> / {catalog.length}</span>
          </div>
          <div className="delta flat">pages with at least one test on record</div>
        </div>
        <div className="summary-card">
          <div className="label">History window</div>
          <div className="big" style={{ fontSize: 20 }}>
            {dateKeys.length ? `${fmtDay(dateKeys[0])} → ${fmtDay(dateKeys[dateKeys.length - 1])}` : "No runs yet"}
          </div>
          <div className="delta flat">last {dateKeys.length || 15} day(s), day-wise</div>
        </div>
      </div>

      {dateKeys.length > 1 && (
        <div className="chart-card">
          <div className="label">Fleet average score over time</div>
          <ResponsiveContainer width="100%" height={220}>
            <LineChart data={trend} margin={{ top: 8, right: 16, left: -16, bottom: 0 }}>
              <CartesianGrid stroke="#E1DFD5" vertical={false} />
              <XAxis dataKey="label" tick={{ fontSize: 12, fill: "#5B6058" }} axisLine={{ stroke: "#DEDCD3" }} tickLine={false} />
              <YAxis domain={[0, 100]} tick={{ fontSize: 12, fill: "#5B6058" }} axisLine={false} tickLine={false} />
              <Tooltip
                formatter={(value, name, props) => [value === null ? "no data" : value, "avg score"]}
                labelStyle={{ fontFamily: "var(--sans)" }}
                contentStyle={{ border: "1px solid #DEDCD3", borderRadius: 0, fontSize: 13 }}
              />
              <Line type="monotone" dataKey="average" stroke="#3F6D5B" strokeWidth={2} dot={{ r: 3 }} connectNulls />
            </LineChart>
          </ResponsiveContainer>
        </div>
      )}
    </>
  );
}

function OverviewTab({ catalog, dateKeys, days }) {
  const groups = [...new Set(catalog.map((c) => c.group))];
  return (
    <table className="overview">
      <thead>
        <tr>
          <th>Page</th>
          <th>Latest</th>
          <th>Last {dateKeys.length || 15} days</th>
          <th>Δ</th>
        </tr>
      </thead>
      <tbody>
        {groups.map((g) => (
          <>
            <tr className="group-row" key={g}>
              <td colSpan={4}>{g}</td>
            </tr>
            {catalog
              .filter((c) => c.group === g)
              .map((item) => (
                <tr key={item.url}>
                  <td>
                    <span className="url-name">{item.label}</span>
                    <span className="url-path">{item.url}</span>
                  </td>
                  <td>
                    <StatusPill url={item.url} dateKeys={dateKeys} days={days} />
                  </td>
                  <td>
                    <Sparkline url={item.url} dateKeys={dateKeys} days={days} />
                  </td>
                  <td>
                    <DeltaCell url={item.url} dateKeys={dateKeys} days={days} />
                  </td>
                </tr>
              ))}
          </>
        ))}
      </tbody>
    </table>
  );
}

function DayTab({ catalog, dateKeys, days }) {
  const [activeDay, setActiveDay] = useState(dateKeys[dateKeys.length - 1] || null);
  if (!dateKeys.length) {
    return (
      <div className="empty">
        <b>No day-wise reports yet.</b>
        <br />
        Once the admin uploads a day's results, they'll show up here.
      </div>
    );
  }
  const day = activeDay && dateKeys.includes(activeDay) ? activeDay : dateKeys[dateKeys.length - 1];
  const dayData = days[day] || {};
  const rows = Object.entries(dayData)
    .map(([url, rec]) => ({ url, rec, item: catalog.find((c) => c.url === url) }))
    .sort((a, b) => (a.rec.score ?? 999) - (b.rec.score ?? 999));

  return (
    <>
      <div className="daylist">
        {dateKeys.map((d) => (
          <button key={d} className={d === day ? "active" : ""} onClick={() => setActiveDay(d)}>
            {fmtDay(d)}
          </button>
        ))}
      </div>
      <table className="overview">
        <thead>
          <tr>
            <th>Page</th>
            <th>Score</th>
            <th>LCP</th>
            <th>CLS</th>
            <th>TBT</th>
          </tr>
        </thead>
        <tbody>
          {rows.length === 0 && (
            <tr>
              <td colSpan={5} style={{ color: "var(--ink-soft)" }}>
                No pages tested this day.
              </td>
            </tr>
          )}
          {rows.map(({ url, rec, item }) => (
            <tr key={url}>
              <td>
                <span className="url-name">{item ? item.label : url}</span>
                <span className="url-path">{url}</span>
              </td>
              <td>
                {rec.status === "done" ? (
                  <span className={`pill ${gradeClass(rec.grade, rec.score)}`}>
                    {rec.score} · {rec.grade || "—"}
                  </span>
                ) : (
                  <span className={`pill ${rec.status === "pending" ? "pending" : "bad"}`}>{rec.status}</span>
                )}
              </td>
              <td>{rec.status === "done" && typeof (rec.lcp_ms ?? rec.lcp) === "number" ? `${((rec.lcp_ms ?? rec.lcp) / 1000).toFixed(2)}s` : "—"}</td>
              <td>{rec.status === "done" && typeof rec.cls === "number" ? rec.cls : "—"}</td>
              <td>{rec.status === "done" && typeof (rec.tbt_ms ?? rec.tbt) === "number" ? `${rec.tbt_ms ?? rec.tbt}ms` : "—"}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </>
  );
}

export default function Dashboard({ dateKeys, days, catalog, error }) {
  const [tab, setTab] = useState("overview");

  return (
    <div className="wrap">
      <header className="top">
        <div>
          <h1>ShopLC Performance</h1>
          <div className="sub">
            GTmetrix scores for {catalog.length} campaign pages, tracked day by day over a rolling {dateKeys.length || 15}-day
            window.
          </div>
        </div>
        <div className="meta">
          <div>{dateKeys.length ? `updated ${fmtDay(dateKeys[dateKeys.length - 1])}` : "no data yet"}</div>
          <a className="admin-link" href="/admin">
            admin
          </a>
        </div>
      </header>

      {error && (
        <div className="empty" style={{ marginBottom: 20 }}>
          <b>Could not load data.</b>
          <br />
          {error}
        </div>
      )}

      {!error && dateKeys.length === 0 && (
        <div className="empty">
          <b>No results uploaded yet.</b>
          <br />
          Run the tracker locally, then have an admin upload today&apos;s file from <code>/admin</code>.
        </div>
      )}

      {!error && dateKeys.length > 0 && (
        <>
          <SummaryAndTrend catalog={catalog} dateKeys={dateKeys} days={days} />
          <nav className="tabs">
            <button className={tab === "overview" ? "active" : ""} onClick={() => setTab("overview")}>
              Overview
            </button>
            <button className={tab === "day" ? "active" : ""} onClick={() => setTab("day")}>
              Day-by-day
            </button>
          </nav>
          {tab === "overview" ? (
            <OverviewTab catalog={catalog} dateKeys={dateKeys} days={days} />
          ) : (
            <DayTab catalog={catalog} dateKeys={dateKeys} days={days} />
          )}
        </>
      )}

      <footer className="foot">
        <span>Read-only report — no login needed to view.</span>
        <span>{catalog.length} pages tracked</span>
      </footer>
    </div>
  );
}
