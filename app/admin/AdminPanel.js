"use client";

import { useRef, useState } from "react";
import { useRouter } from "next/navigation";

function todayKey() {
  const d = new Date();
  return d.getFullYear() + "-" + String(d.getMonth() + 1).padStart(2, "0") + "-" + String(d.getDate()).padStart(2, "0");
}

function LoginForm() {
  const router = useRouter();
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const [busy, setBusy] = useState(false);

  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setError(null);
    try {
      const res = await fetch("/api/admin/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ password }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.error || "Login failed.");
      } else {
        router.refresh();
      }
    } catch (err) {
      setError(String(err));
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="admin-shell">
      <div className="admin-card">
        <h1>Admin sign-in</h1>
        <p className="sub">Only admins can upload result files. Everyone else can view the report without signing in.</p>
        {error && <div className="error">{error}</div>}
        <form onSubmit={submit}>
          <input
            type="password"
            placeholder="Admin password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            autoFocus
          />
          <button className="action" type="submit" disabled={busy || !password}>
            {busy ? "Checking…" : "Sign in"}
          </button>
        </form>
      </div>
    </div>
  );
}

function UploadPanel() {
  const router = useRouter();
  const fileRef = useRef(null);
  const [day, setDay] = useState(todayKey());
  const [message, setMessage] = useState(null);
  const [error, setError] = useState(null);
  const [busy, setBusy] = useState(false);

  async function logout() {
    await fetch("/api/admin/logout", { method: "POST" });
    router.refresh();
  }

  async function submit(e) {
    e.preventDefault();
    setError(null);
    setMessage(null);
    const file = fileRef.current?.files?.[0];
    if (!file) {
      setError("Choose a data file first — the data/YYYY-MM-DD.json produced by the local tracker.");
      return;
    }
    setBusy(true);
    try {
      const text = await file.text();
      let results;
      try {
        results = JSON.parse(text);
      } catch {
        setError("That file isn't valid JSON.");
        setBusy(false);
        return;
      }
      const res = await fetch("/api/admin/upload", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ day, results }),
      });
      const data = await res.json();
      if (!res.ok) {
        setError(data.error || "Upload failed.");
      } else {
        setMessage(`Saved ${data.urlCount} page result(s) for ${data.day}.`);
        if (fileRef.current) fileRef.current.value = "";
      }
    } catch (err) {
      setError(String(err));
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="admin-shell">
      <div className="admin-topbar">
        <span style={{ fontSize: 13, color: "var(--ink-soft)" }}>Signed in as admin</span>
        <button className="link" onClick={logout}>
          Sign out
        </button>
      </div>
      <div className="admin-card">
        <h1>Upload a day&apos;s results</h1>
        <p className="sub">
          Upload the <code>data/YYYY-MM-DD.json</code> file produced by the local tracker (run in Cursor / Claude Code). It
          gets merged into that day&apos;s report — existing pages already recorded for the day are kept unless this file
          overwrites them.
        </p>
        {error && <div className="error">{error}</div>}
        {message && <div className="success">{message}</div>}
        <form onSubmit={submit}>
          <input type="date" value={day} onChange={(e) => setDay(e.target.value)} />
          <input type="file" accept="application/json" ref={fileRef} />
          <button className="action" type="submit" disabled={busy}>
            {busy ? "Uploading…" : "Upload"}
          </button>
        </form>
      </div>
      <p style={{ fontSize: 12, color: "var(--ink-soft)", marginTop: 16 }}>
        <a href="/">← back to the public report</a>
      </p>
    </div>
  );
}

export default function AdminPanel({ authed }) {
  return authed ? <UploadPanel /> : <LoginForm />;
}
