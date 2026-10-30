# Shop LC — Website Performance Monitor

Daily GTmetrix benchmark for Shop LC pages (Desktop + Mobile), hosted on Vercel with Supabase storage.

The dashboard UI (`public/monitor.html`, served at `/`) is the VGL Brand Website Performance Monitor
front-end, wired to this app's own API instead of Netlify functions / GitHub Actions:

| Original                              | Here                                   |
|---------------------------------------|----------------------------------------|
| `data.js` (static)                    | `/data.js` (→ `/api/perf-data`) — page list + thresholds from Supabase |
| Supabase REST `benchmark_runs`, `monitored_urls`, `url_change_log` | `/api/sb/rest/v1/*` (server-side proxy; writes need the admin passphrase) |
| `/.netlify/functions/trigger-run`     | `/api/trigger-run` — queues GTmetrix tests |
| `/.netlify/functions/list-runs`       | `/api/list-runs`                        |
| GitHub Actions 5am job                | Vercel Cron `/api/cron` + `/api/tick` queue |

Added on top of the original: a **GTmetrix Report** row with links to each test's full report.

- **GTmetrix Benchmark** — every page × device, colour-coded against thresholds, day-by-day timeline, cards or table.
- **Actionable** — rule engine ranks the top fixes per page (CRITICAL / HIGH / MEDIUM), mobile weighted first.
- **Monitored URLs** — add, remove, reorder, pause pages and pick the GTmetrix test location (admin).
- **Run Tests - Admin** — passphrase-locked. One click runs today's report; or re-run selected pages only.
- **Daily schedule** — Vercel Cron at 05:00 UTC = 05:00 London in winter, same slot as the original flagship run (`vercel.json`).
- **Public read-only link** — anyone with the URL sees every tab and the day-by-day history; only the admin passphrase can run, re-run or edit URLs.
- **GTmetrix report links** — every page/device result links to its full GTmetrix report (cards, table and Actionable).
- **Day-by-day trend** — Performance Score per page per day, click a point to open that day.
- **Same parameters as the original VGL monitor** — Shop LC pages tested from **Chicago, IL, USA**; identical good / acceptable / poor thresholds for all 12 metrics; URL change log with the editor's name.

## How a run works

GTmetrix tests take 1–2 minutes and your plan limits parallel tests, so runs are a queue in Supabase:
`/api/run` (or `/api/cron`) creates a run with one row per page × device → `/api/tick` submits up to
`GTMETRIX_MAX_CONCURRENT` tests, polls them, stores the report metrics, and re-invokes itself until the
queue is empty. The dashboard also nudges the queue while it's open.

Each test uses GTmetrix API credits (16 tests per full run for 8 pages).

## Setup (≈10 minutes)

1. **Supabase** — create a project → SQL Editor → run `supabase/schema.sql`, then `supabase/migrate_002.sql`.
   Optional: then run `supabase/seed_history.sql` to import the 60 days of Shop LC history (1 Sep – 30 Oct 2026) from the original monitor, so the trend starts full.
   Copy *Project URL* and the *service_role* key from Project Settings → API.
2. **GTmetrix** — Account → API → copy your API key.
3. **Vercel** — *Add New → Project* → import this GitHub repo (framework auto-detects Next.js).
   Add the environment variables from `.env.example`:

   | Variable | Value |
   |---|---|
   | `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY` | from step 1 |
   | `GTMETRIX_API_KEY` | from step 2 |
   | `ADMIN_PASSWORD` | your passphrase for running tests / editing URLs |
   | `SITE_PASSWORD` | leave empty for a public read-only link |
   | `SESSION_SECRET`, `CRON_SECRET` | any long random strings (`openssl rand -hex 32`) |
   | `GTMETRIX_LOCATION` | `Chicago` (same as the original); city name or GTmetrix id |
   | `GTMETRIX_RETENTION` | optional — months report links stay live (plan dependent) |
   | `GTMETRIX_MAX_CONCURRENT` | parallel tests your plan allows (default 2) |
   | `GTMETRIX_MOBILE_DEVICE` | optional PRO simulated-device id for real mobile emulation |
   | `APP_TIMEZONE` | defines "today" (default `Europe/London`, like the original) |

4. Deploy. Open the site → **Run Tests - Admin** → enter passphrase → **Run Today**.

## Local dev

```bash
cp .env.example .env.local   # fill in values
npm install
npm run dev
```

## Tuning

Thresholds, targets and fix advice live in `lib/rules.js`. Change the cron time in `vercel.json`.
