'use client';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { METRICS, fmt, fmtTarget, band, gradeBand, actionsFor } from '@/lib/rules';

const api = async (path, opts = {}) => {
  const r = await fetch(path, { ...opts, headers: { 'content-type': 'application/json', ...(opts.headers || {}) } });
  const j = await r.json().catch(() => ({}));
  if (!r.ok) throw new Error(j.error || r.statusText);
  return j;
};
const prettyDate = (d) => new Date(d + 'T12:00:00').toLocaleDateString('en-GB', { weekday: 'short', day: 'numeric', month: 'short' });
const shortUrl = (u) => u.replace(/^https?:\/\//, '');

function groupByPage(results, urls) {
  const pages = new Map();
  const order = new Map(urls.map((u, i) => [u.id, i]));
  for (const r of results) {
    const k = `${r.url_id || r.url}|${r.page_type}`;
    if (!pages.has(k)) pages.set(k, { key: k, url_id: r.url_id, page_type: r.page_type, url: r.url, desktop: null, mobile: null });
    pages.get(k)[r.device] = r;
  }
  return [...pages.values()].sort((a, b) => (order.get(a.url_id) ?? 999) - (order.get(b.url_id) ?? 999));
}

function Val({ m, r }) {
  if (!r || r.status !== 'completed') return <span className="v na">{r?.status === 'error' ? 'err' : '—'}</span>;
  return <span className={`v ${band(m, r[m.key]) || 'na'}`}>{fmt(m, r[m.key])}</span>;
}
function Grade({ r }) {
  if (!r || r.status !== 'completed') return <span className="v na">—</span>;
  return <span className={`v ${gradeBand(r.grade) || 'na'}`}>{r.grade || '—'}</span>;
}

function ReportLinks({ p }) {
  return (
    <div className="rlinks">
      {['desktop', 'mobile'].map((d) => p[d]?.report_url
        ? <a key={d} className="rlink" href={p[d].report_url} target="_blank" rel="noreferrer">{d === 'desktop' ? 'Desktop' : 'Mobile'} report ↗</a>
        : <span key={d} className="rlink off" title={p[d]?.error || 'No GTmetrix report for this day'}>{d === 'desktop' ? 'Desktop' : 'Mobile'} report —</span>)}
    </div>
  );
}

export default function Dashboard() {
  const [tab, setTab] = useState('bench');
  const [data, setData] = useState(null);
  const [date, setDate] = useState(null);
  const [err, setErr] = useState('');
  const [view, setView] = useState('cards');

  const load = useCallback(async (d) => {
    try {
      const j = await api('/api/data' + (d ? `?date=${d}` : ''));
      setData(j); setDate(j.date); setErr('');
    } catch (e) { setErr(e.message); if (/Unauthorized/.test(e.message)) location.href = '/login'; }
  }, []);
  useEffect(() => { load(); }, [load]);

  // While a run is active, keep the queue moving and refresh
  useEffect(() => {
    if (!data?.active) return;
    const t = setInterval(async () => {
      try { await api('/api/tick', { method: 'POST' }); } catch {}
      load(date);
    }, 12000);
    return () => clearInterval(t);
  }, [data?.active, date, load]);

  const pages = useMemo(() => (data ? groupByPage(data.results, data.urls) : []), [data]);
  const isAdmin = data?.role === 'admin';

  if (!data) return <main className="wrap"><p className="muted">{err || 'Loading…'}</p></main>;

  return (
    <main className="wrap">
      <header className="top">
        <div className="logo">LC</div>
        <div>
          <h1>Shop LC — Website Performance Monitor</h1>
          <div className="muted">{data.urls.filter((u) => u.active).length} pages · Desktop & Mobile · GTmetrix · tested from {data.urls[0]?.location || 'Chicago, IL, USA'}</div>
        </div>
        <div className="spacer" />
        {data.role !== 'public' && <button className="btn sm" onClick={async () => { await api('/api/logout', { method: 'POST' }); location.href = '/'; }}>Sign out</button>}
      </header>

      <nav className="tabs">
        {[['bench', 'GTmetrix Benchmark'], ['actions', 'Actionable'], ['urls', 'Monitored URLs'], ['admin', `Run Tests - Admin ${isAdmin ? '' : '🔒'}`]].map(([k, l]) => (
          <button key={k} className={tab === k ? 'on' : ''} onClick={() => setTab(k)}>{l}</button>
        ))}
      </nav>

      <div className="bar">
        <span className="pill live">LIVE · SUPABASE</span>
        {date && <b>{prettyDate(date)}</b>}
        {data.active && <span className="pill" style={{ background: '#fff4d6', color: '#a86a00' }}>Run in progress…</span>}
        {err && <span className="err">{err}</span>}
      </div>

      {(tab === 'bench' || tab === 'actions') && data.dates.length > 0 && (
        <div className="timeline" ref={(el) => { if (el && !el.dataset.done) { el.scrollLeft = el.scrollWidth; el.dataset.done = '1'; } }}>
          {data.dates.slice(-60).map((d) => (
            <button key={d} className={d === date ? 'on' : ''} onClick={() => load(d)}>{prettyDate(d)}</button>
          ))}
        </div>
      )}

      {tab === 'bench' && <Benchmark pages={pages} view={view} setView={setView} trend={data.trend} urls={data.urls} onPick={load} />}
      {tab === 'actions' && <Actionable pages={pages} date={date} />}
      {tab === 'urls' && <Urls data={data} isAdmin={isAdmin} reload={() => load(date)} />}
      {tab === 'admin' && <Admin data={data} isAdmin={isAdmin} reload={() => load()} />}

      <footer>
        Shop LC Performance Monitor · data from GTmetrix · {data.dates.length} days of history
        {data.runs[0] && <> · last run {new Date(data.runs[0].created_at).toLocaleString()}</>}
      </footer>
    </main>
  );
}

function Benchmark({ pages, view, setView, trend, urls, onPick }) {
  if (view === 'trend') return <><ViewSwitch view={view} setView={setView} /><Trend trend={trend} urls={urls} onPick={onPick} /></>;
  if (!pages.length) return <div className="card muted">No results for this day yet. Use “Run Tests - Admin” to run today’s report.</div>;
  return (
    <>
      <ViewSwitch view={view} setView={setView} />
      {view === 'cards' ? (
        <div className="grid">
          {pages.map((p) => (
            <div className="card" key={p.key}>
              <h3 className="ptitle">{p.page_type}</h3>
              <div className="purl"><a href={p.url} target="_blank" rel="noreferrer">{shortUrl(p.url)}</a></div>
              <ReportLinks p={p} />
              <table style={{ marginTop: 8 }}>
                <thead><tr><th>Metric</th><th className="c">Desktop</th><th className="c">Mobile</th></tr></thead>
                <tbody>
                  <tr><td>GTmetrix Grade</td><td className="c"><Grade r={p.desktop} /></td><td className="c"><Grade r={p.mobile} /></td></tr>
                  {METRICS.map((m) => (
                    <tr key={m.key}><td>{m.label}</td><td className="c"><Val m={m} r={p.desktop} /></td><td className="c"><Val m={m} r={p.mobile} /></td></tr>
                  ))}
                </tbody>
              </table>
            </div>
          ))}
        </div>
      ) : (
        <div className="card scroll">
          <table>
            <thead><tr><th>Page</th><th>Device</th><th className="c">Grade</th>{METRICS.map((m) => <th key={m.key} className="c">{m.label}</th>)}<th>Report</th></tr></thead>
            <tbody>
              {pages.flatMap((p) => ['desktop', 'mobile'].map((d) => (
                <tr key={p.key + d}>
                  <td>{d === 'desktop' ? <><b>{p.page_type}</b><div className="purl">{shortUrl(p.url)}</div></> : ''}</td>
                  <td>{d}</td><td className="c"><Grade r={p[d]} /></td>
                  {METRICS.map((m) => <td key={m.key} className="c"><Val m={m} r={p[d]} /></td>)}
                  <td>{p[d]?.report_url ? <a href={p[d].report_url} target="_blank" rel="noreferrer">GTmetrix ↗</a> : '—'}</td>
                </tr>
              )))}
            </tbody>
          </table>
        </div>
      )}
    </>
  );
}

function ViewSwitch({ view, setView }) {
  return (
    <div className="bar">
      <div className="seg">
        {[['cards', 'Cards'], ['table', 'Table'], ['trend', 'Day-by-day trend']].map(([k, l]) => (
          <button key={k} className={view === k ? 'on' : ''} onClick={() => setView(k)}>{l}</button>
        ))}
      </div>
      <div className="spacer" />
      <div className="legend"><span><i style={{ background: '#1f7a3a' }} />Good</span><span><i style={{ background: '#d69e00' }} />Acceptable / Needs improvement</span><span><i style={{ background: '#b42318' }} />Poor</span></div>
    </div>
  );
}

function Chart({ series, dates, onPick }) {
  const W = 640, H = 170, L = 30, R = 8, T = 10, B = 22;
  const x = (i) => L + (dates.length < 2 ? 0 : (i * (W - L - R)) / (dates.length - 1));
  const y = (v) => T + (1 - v / 100) * (H - T - B);
  const colors = { desktop: '#16213e', mobile: '#c9a24a' };
  return (
    <svg viewBox={`0 0 ${W} ${H}`} style={{ width: '100%', height: 'auto' }} role="img" aria-label="Performance score by day">
      {[90, 50].map((g) => <line key={g} x1={L} x2={W - R} y1={y(g)} y2={y(g)} stroke={g === 90 ? '#1f7a3a' : '#b42318'} strokeDasharray="3 4" strokeOpacity=".5" />)}
      {[0, 50, 100].map((g) => <text key={g} x={L - 6} y={y(g) + 4} fontSize="10" textAnchor="end" fill="#6b7280">{g}</text>)}
      {[0, Math.floor((dates.length - 1) / 2), dates.length - 1].filter((v, i, a) => a.indexOf(v) === i && dates[v]).map((i) => (
        <text key={i} x={x(i)} y={H - 6} fontSize="10" textAnchor={i === 0 ? 'start' : i === dates.length - 1 ? 'end' : 'middle'} fill="#6b7280">{prettyDate(dates[i])}</text>
      ))}
      {Object.entries(series).map(([dev, vals]) => {
        const pts = vals.map((v, i) => (v == null ? null : [x(i), y(v)]));
        let d = '', pen = false;
        pts.forEach((p) => { if (!p) { pen = false; return; } d += (pen ? 'L' : 'M') + p[0].toFixed(1) + ' ' + p[1].toFixed(1); pen = true; });
        return (
          <g key={dev}>
            <path d={d} fill="none" stroke={colors[dev]} strokeWidth="2" />
            {pts.map((p, i) => p && (
              <circle key={i} cx={p[0]} cy={p[1]} r="3" fill={colors[dev]} style={{ cursor: 'pointer' }} onClick={() => onPick(dates[i])}>
                <title>{`${prettyDate(dates[i])} · ${dev}: ${vals[i]}%`}</title>
              </circle>
            ))}
          </g>
        );
      })}
    </svg>
  );
}

function Trend({ trend, urls, onPick }) {
  const dates = [...new Set(trend.map((t) => t.run_date))].sort();
  if (!dates.length) return <div className="card muted">No history yet.</div>;
  const idx = new Map(dates.map((d, i) => [d, i]));
  const pages = urls.map((u) => ({ u, desktop: Array(dates.length).fill(null), mobile: Array(dates.length).fill(null) }));
  const byId = new Map(pages.map((p) => [p.u.id, p]));
  for (const t of trend) { const p = byId.get(t.url_id); if (p && t.performance != null) p[t.device][idx.get(t.run_date)] = Number(t.performance); }
  return (
    <>
      <div className="muted" style={{ marginBottom: 8 }}>GTmetrix Performance Score per day · <b style={{ color: '#16213e' }}>● Desktop</b> <b style={{ color: '#c9a24a' }}>● Mobile</b> · dashed lines = Good (90) and Poor (50) · click a point to open that day</div>
      <div className="grid">
        {pages.filter((p) => p.desktop.some((v) => v != null) || p.mobile.some((v) => v != null)).map((p) => {
          const last = (a) => [...a].reverse().find((v) => v != null);
          return (
            <div className="card" key={p.u.id}>
              <div className="bar" style={{ marginBottom: 4 }}>
                <div><h3 className="ptitle">{p.u.page_type}</h3><div className="purl">{shortUrl(p.u.url)}</div></div>
                <div className="spacer" />
                <span className="muted">latest D {last(p.desktop) ?? '—'} · M {last(p.mobile) ?? '—'}</span>
              </div>
              <Chart series={{ desktop: p.desktop, mobile: p.mobile }} dates={dates} onPick={onPick} />
            </div>
          );
        })}
      </div>
    </>
  );
}

function Actionable({ pages, date }) {
  const total = pages.reduce((s, p) => s + actionsFor(p).total, 0);
  return (
    <>
      <div className="card">
        <b>Actionable — Development Priorities</b>
        <div className="muted">Snapshot {date} · ranked fixes per page · mobile weighted first · each item shows the current value, the target, and what to change · {total} issues</div>
        <div className="legend" style={{ marginTop: 8 }}>
          <span><span className="sev CRITICAL">CRITICAL</span> worse than “Poor”</span>
          <span><span className="sev HIGH">HIGH</span> worse than “Acceptable”</span>
          <span><span className="sev MEDIUM">MEDIUM</span> short of the “Good” target</span>
        </div>
      </div>
      {pages.map((p) => {
        const { top } = actionsFor(p);
        return (
          <div className="card" key={p.key}>
            <div className="bar" style={{ marginBottom: 4 }}>
              <div><h3 className="ptitle">{p.page_type}</h3><div className="purl">{shortUrl(p.url)}</div><ReportLinks p={p} /></div>
              <div className="spacer" />
              <span className="muted">Desktop</span> <Grade r={p.desktop} /> <span className="muted">Mobile</span> <Grade r={p.mobile} />
            </div>
            {top.length === 0 ? <div className="muted">All monitored metrics within target on Desktop & Mobile (or no completed results).</div> :
              top.map((a, i) => (
                <div className="act" key={i}>
                  <div><span className={`sev ${a.sev}`}>{a.sev}</span><div className="dev">{a.device}</div></div>
                  <div><b>{a.m.title}</b><small>{a.m.advice}</small></div>
                  <div className="nowt"><span className="now">{fmt(a.m, a.value)}</span> → <span className="tgt">{fmtTarget(a.m)}</span><div className="muted" style={{ fontWeight: 400 }}>NOW / TARGET</div></div>
                </div>
              ))}
          </div>
        );
      })}
    </>
  );
}

function Urls({ data, isAdmin, reload }) {
  const [edit, setEdit] = useState(false);
  const [rows, setRows] = useState(data.urls);
  const [locs, setLocs] = useState([]);
  const [msg, setMsg] = useState('');
  const [who, setWho] = useState('');
  useEffect(() => { try { setWho(localStorage.getItem('pm_name') || ''); } catch {} }, []);
  useEffect(() => { if (!edit) setRows(data.urls); }, [data.urls, edit]);
  useEffect(() => { if (edit) api('/api/locations').then((j) => setLocs(j.locations)).catch(() => {}); }, [edit]);
  const upd = (i, k, v) => setRows(rows.map((r, j) => (j === i ? { ...r, [k]: v } : r)));
  const move = (i, d) => { const n = [...rows]; const j = i + d; if (j < 0 || j >= n.length) return; [n[i], n[j]] = [n[j], n[i]]; setRows(n); };

  async function save() {
    setMsg('Saving…');
    try { localStorage.setItem('pm_name', who); } catch {}
    try { await api('/api/urls', { method: 'PUT', body: JSON.stringify({ urls: rows, changedBy: who }) }); setMsg('Saved'); setEdit(false); reload(); }
    catch (e) { setMsg(e.message); }
  }

  return (
    <div className="card scroll">
      <div className="bar">
        <b>Monitored URLs</b><span className="muted">The pages tested on every run</span>
        <div className="spacer" />
        {msg && <span className="muted">{msg}</span>}
        {isAdmin && !edit && <button className="btn sm" onClick={() => setEdit(true)}>Edit URLs</button>}
        {!isAdmin && <span className="muted">Unlock in “Run Tests - Admin” to edit</span>}
        {edit && <>
          <input style={{ width: 150 }} value={who} onChange={(e) => setWho(e.target.value)} placeholder="Your name (logged)" />
          <button className="btn sm" onClick={() => setRows([...rows, { page_type: '', url: 'https://www.shoplc.com/', location: rows[0]?.location || 'Chicago, IL, USA', active: true }])}>+ Add page</button>
          <button className="btn sm" onClick={() => { setEdit(false); setRows(data.urls); setMsg(''); }}>Cancel</button>
          <button className="btn sm primary" onClick={save}>Save</button>
        </>}
      </div>
      <table>
        <thead><tr><th>Type</th><th>URL</th><th>Location</th><th className="c">Active</th>{edit && <th />}</tr></thead>
        <tbody>
          {rows.map((u, i) => (
            <tr key={u.id || 'new' + i}>
              {edit ? <>
                <td style={{ minWidth: 150 }}><input value={u.page_type} placeholder="e.g. Product / PDP" onChange={(e) => upd(i, 'page_type', e.target.value)} /></td>
                <td style={{ minWidth: 300 }}><input value={u.url} onChange={(e) => upd(i, 'url', e.target.value)} /></td>
                <td style={{ minWidth: 160 }}>{locs.length ? (
                  <select value={u.location} onChange={(e) => upd(i, 'location', e.target.value)}>
                    {!locs.some((l) => l.name === u.location) && <option value={u.location}>{u.location}</option>}
                    {locs.map((l) => <option key={l.id} value={l.name}>{l.name}</option>)}
                  </select>
                ) : <input value={u.location} onChange={(e) => upd(i, 'location', e.target.value)} />}</td>
                <td className="c"><input type="checkbox" style={{ width: 'auto' }} checked={u.active !== false} onChange={(e) => upd(i, 'active', e.target.checked)} /></td>
                <td style={{ whiteSpace: 'nowrap' }}>
                  <button className="btn sm" onClick={() => move(i, -1)}>↑</button> <button className="btn sm" onClick={() => move(i, 1)}>↓</button>{' '}
                  <button className="btn sm" onClick={() => setRows(rows.filter((_, j) => j !== i))}>✕</button>
                </td>
              </> : <>
                <td><b>{u.page_type}</b></td>
                <td><a href={u.url} target="_blank" rel="noreferrer" style={{ wordBreak: 'break-all' }}>{u.url}</a></td>
                <td>{u.location}</td>
                <td className="c">{u.active ? '✓' : '—'}</td>
              </>}
            </tr>
          ))}
        </tbody>
      </table>
      {data.changes?.length > 0 && (
        <>
          <div className="bar" style={{ marginTop: 16 }}><b>Change log</b><span className="muted">every URL edit, newest first</span></div>
          <table>
            <thead><tr><th>When</th><th>Who</th><th>Action</th><th>Page</th><th>From → To</th></tr></thead>
            <tbody>{data.changes.map((c) => (
              <tr key={c.id}><td style={{ whiteSpace: 'nowrap' }}>{new Date(c.created_at).toLocaleString('en-GB', { day: 'numeric', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' })}</td>
                <td>{c.changed_by}</td><td>{c.action}</td><td>{c.page_type}</td>
                <td className="purl">{c.old_url && c.new_url && c.old_url !== c.new_url ? <>{shortUrl(c.old_url)} → {shortUrl(c.new_url)}</> : shortUrl(c.new_url || c.old_url || '')}</td></tr>
            ))}</tbody>
          </table>
        </>
      )}
    </div>
  );
}

function Admin({ data, isAdmin, reload }) {
  const [pw, setPw] = useState('');
  const [msg, setMsg] = useState('');
  const [busy, setBusy] = useState(false);
  const [pick, setPick] = useState({});

  async function unlock(e) {
    e.preventDefault(); setMsg('');
    try { const j = await api('/api/login', { method: 'POST', body: JSON.stringify({ password: pw }) }); if (j.role !== 'admin') setMsg('That password is view-only.'); reload(); }
    catch { setMsg('Wrong passphrase'); }
  }
  async function run(urlIds) {
    setBusy(true); setMsg('Starting…');
    try {
      const j = await api('/api/run', { method: 'POST', body: JSON.stringify({ urlIds }) });
      setMsg(j.alreadyRunning ? 'A run is already in progress.' : `Queued ${j.queued} tests${j.credits != null ? ` · GTmetrix credits left: ${j.credits}` : ''}`);
      setPick({}); reload();
    } catch (e) { setMsg(e.message); }
    setBusy(false);
  }

  if (!isAdmin) return (
    <div className="center" style={{ minHeight: 'auto' }}>
      <form className="card lock" onSubmit={unlock}>
        <div style={{ fontSize: 28 }}>🔒</div>
        <h2>Run Performance Benchmark On-Demand</h2>
        <p className="muted">Enter the admin passphrase to unlock on-demand runs and URL editing.</p>
        <input type="password" value={pw} onChange={(e) => setPw(e.target.value)} placeholder="Admin passphrase" />
        {msg && <p className="err">{msg}</p>}
        <button className="btn primary">Submit</button>
      </form>
    </div>
  );

  const rows = data.activeRows || [];
  const done = rows.filter((r) => r.status === 'completed' || r.status === 'error').length;
  const picked = Object.keys(pick).filter((k) => pick[k]);
  const active = data.urls.filter((u) => u.active);

  return (
    <>
      <div className="card">
        <div className="bar">
          <div><b>Run today’s report</b><div className="muted">Tests every active page on Desktop + Mobile via GTmetrix ({active.length * 2} tests). Also runs automatically every day.</div></div>
          <div className="spacer" />
          <button className="btn gold" disabled={busy || !!data.active} onClick={() => run()}>▶ Run Today ({active.length} pages)</button>
        </div>
        {msg && <div className="muted">{msg}</div>}
        {data.active && (
          <>
            <div className="progress"><div style={{ width: `${rows.length ? (done / rows.length) * 100 : 0}%` }} /></div>
            <div className="muted">{done} / {rows.length} tests finished · each test takes ~1–2 min; the page refreshes automatically.</div>
            <table style={{ marginTop: 8 }}>
              <tbody>{rows.map((r) => (
                <tr key={r.id}><td>{r.page_type}</td><td>{r.device}</td><td><span className={`status ${r.status}`}>{r.status}</span></td>
                  <td>{r.grade ? <Grade r={{ ...r, status: 'completed' }} /> : r.error ? <span className="err">{r.error}</span> : ''}</td></tr>
              ))}</tbody>
            </table>
          </>
        )}
      </div>

      <div className="card">
        <div className="bar">
          <b>Re-run selected pages</b><div className="spacer" />
          <button className="btn sm primary" disabled={busy || !!data.active || !picked.length} onClick={() => run(picked)}>Re-run {picked.length || ''} selected</button>
        </div>
        {active.map((u) => (
          <label key={u.id} style={{ display: 'flex', gap: 8, alignItems: 'center', padding: '4px 0' }}>
            <input type="checkbox" style={{ width: 'auto' }} checked={!!pick[u.id]} onChange={(e) => setPick({ ...pick, [u.id]: e.target.checked })} />
            <b>{u.page_type}</b> <span className="purl">{shortUrl(u.url)}</span>
          </label>
        ))}
      </div>

      <div className="card">
        <b>Recent runs</b>
        <table style={{ marginTop: 8 }}>
          <thead><tr><th>Date</th><th>Trigger</th><th>Status</th><th>Started</th><th>Finished</th></tr></thead>
          <tbody>{data.runs.map((r) => (
            <tr key={r.id}><td>{r.run_date}</td><td>{r.triggered_by}</td><td><span className={`status ${r.status === 'done' ? 'completed' : 'submitted'}`}>{r.status}</span></td>
              <td>{new Date(r.created_at).toLocaleTimeString()}</td><td>{r.finished_at ? new Date(r.finished_at).toLocaleTimeString() : '—'}</td></tr>
          ))}</tbody>
        </table>
      </div>
    </>
  );
}
