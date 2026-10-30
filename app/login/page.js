'use client';
import { useState } from 'react';

export default function Login() {
  const [pw, setPw] = useState('');
  const [err, setErr] = useState('');
  const [busy, setBusy] = useState(false);
  async function submit(e) {
    e.preventDefault();
    setBusy(true); setErr('');
    const r = await fetch('/api/login', { method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify({ password: pw }) });
    setBusy(false);
    if (r.ok) location.href = '/';
    else setErr('Wrong password');
  }
  return (
    <main className="center">
      <form className="card lock" onSubmit={submit}>
        <div className="logo big">LC</div>
        <h2>Shop LC Performance Monitor</h2>
        <p className="muted">Enter the access password</p>
        <input type="password" autoFocus value={pw} onChange={(e) => setPw(e.target.value)} placeholder="Password" />
        {err && <p className="err">{err}</p>}
        <button className="btn primary" disabled={busy}>{busy ? 'Checking…' : 'Sign in'}</button>
      </form>
    </main>
  );
}
