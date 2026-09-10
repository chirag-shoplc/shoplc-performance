# ShopLC Performance Dashboard

Public, read-only report of GTmetrix scores across ~25 campaign pages.
This is the Vercel showcase companion to the local tracker you run in
Cursor.

- **`/`** — the report. Fleet average trend chart, per-page scores
  grouped by campaign, sparkline history, and a day-by-day view. No
  login, open to anyone with the link.

There is no admin UI or password. "Who can update the report" is simply
"who can push to this repo" — updating means committing a new
`data/YYYY-MM-DD.json` file and pushing, which triggers a normal Vercel
rebuild.

## How data gets in

1. Run the local tracker (the separate `perf-tracker/` project, driven by
   Claude Code + the GTmetrix MCP connector in Cursor). It writes
   `perf-tracker/data/2026-09-10.json` (one file per day, keyed by URL).
2. Copy that file into **this** repo's `data/` folder, keeping the same
   `YYYY-MM-DD.json` name.
3. `git add data/2026-09-10.json && git commit -m "perf: 2026-09-10" && git push`
4. Vercel rebuilds automatically. The site always shows the most recent
   15 day-files present in `data/`.

Each file is a plain object keyed by URL:

```json
{
  "https://www.shoplc.com/pages/cane": {
    "status": "done",
    "score": 87,
    "grade": "A",
    "lcp_ms": 1800,
    "cls": 0.02,
    "tbt_ms": 120,
    "tested_at": "2026-09-10T09:15:00.000Z"
  }
}
```

You can commit a partial day (only some URLs tested) — the report just
shows "not tested" for the rest.

## Deploy

1. Push this folder to a GitHub repo, import it in Vercel (Next.js is
   auto-detected). No environment variables or storage add-ons needed.
2. Deploy. Every future push to the default branch (including new
   `data/*.json` files) triggers a rebuild and updates the report.

## Local development

```
npm install
npm run dev
```

Drop a test file straight into `data/` locally to see the report
populate without needing to deploy first.
