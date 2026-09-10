# ShopLC Performance Dashboard

Public, read-only report of GTmetrix scores across ~25 campaign pages, with
an admin-only upload page. This is the Vercel showcase companion to the
local tracker you run in Cursor.

- **`/`** — public. Fleet average trend chart, per-page scores grouped by
  campaign, sparkline history, and a day-by-day view. No login required.
- **`/admin`** — password-protected. Upload the `data/YYYY-MM-DD.json`
  file produced by the local tracker; it gets merged into that day's
  report.

Data is stored in **Vercel Blob** as one JSON file per day
(`data/YYYY-MM-DD.json`), so nothing needs a separate database.

## Deploy

1. Push this folder to a GitHub repo, then import it in Vercel
   (New Project → import repo). Framework preset: Next.js (auto-detected).
2. In the Vercel project: **Storage → Create Database → Blob**, then
   connect it to this project. That automatically sets the
   `BLOB_READ_WRITE_TOKEN` environment variable — you don't need to copy
   it yourself.
3. Still in **Settings → Environment Variables**, add:
   - `ADMIN_PASSWORD` — the password you'll use to sign in at `/admin`.
   - `SESSION_SECRET` — any long random string (used to sign the admin
     session cookie).
4. Deploy. Visit `/` for the public report and `/admin` to sign in and
   upload a day's file.

## Uploading results

After running the local tracker in Cursor (see the `perf-tracker/`
project and its `PERF_TRACKER.md`), you'll have a file like
`perf-tracker/data/2026-09-10.json`. Go to `/admin` on the deployed site,
sign in, pick that date, and upload the file. It merges into whatever's
already recorded for that day, so uploading a partial run (e.g. only one
campaign group) won't erase the rest of that day's results.

The public page always shows the most recent 15 days that have data.

## Local development

```
npm install
cp .env.example .env.local   # fill in ADMIN_PASSWORD, SESSION_SECRET,
                              # and BLOB_READ_WRITE_TOKEN (copy the token
                              # from Vercel's dashboard for local testing)
npm run dev
```

## Notes

- The admin password is a single shared secret, not per-user accounts —
  fine for an internal showcase, but don't reuse a password you care
  about elsewhere.
- The public `/` page and `/api/data` route never require authentication
  by design — only the upload endpoint (`/api/admin/upload`) is gated.
