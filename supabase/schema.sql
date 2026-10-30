-- Shop LC Performance Monitor — run once in Supabase SQL Editor
create extension if not exists pgcrypto;

create table if not exists monitored_urls (
  id          uuid primary key default gen_random_uuid(),
  page_type   text not null,
  url         text not null,
  location    text not null default 'Chicago, IL, USA',  -- GTmetrix city name or numeric id
  sort        int  not null default 0,
  active      boolean not null default true,
  created_at  timestamptz not null default now()
);

-- Append-only audit trail of URL edits (who changed what, when)
create table if not exists url_changes (
  id          uuid primary key default gen_random_uuid(),
  changed_by  text not null,
  action      text not null,          -- added | removed | changed
  page_type   text,
  old_url     text,
  new_url     text,
  created_at  timestamptz not null default now()
);

create table if not exists runs (
  id           uuid primary key default gen_random_uuid(),
  run_date     date not null,
  triggered_by text not null default 'manual',   -- manual | cron
  status       text not null default 'running',  -- running | done
  created_at   timestamptz not null default now(),
  finished_at  timestamptz
);
create index if not exists runs_date_idx on runs (run_date desc);

create table if not exists results (
  id               uuid primary key default gen_random_uuid(),
  run_id           uuid not null references runs(id) on delete cascade,
  url_id           uuid references monitored_urls(id) on delete set null,
  run_date         date not null,
  page_type        text not null,
  url              text not null,
  device           text not null,               -- desktop | mobile
  location         text,
  status           text not null default 'pending', -- pending | submitting | submitted | completed | error
  gtmetrix_test_id text,
  report_url       text,
  grade            text,
  performance      numeric,
  structure        numeric,
  fcp              numeric,   -- ms
  lcp              numeric,   -- ms
  tbt              numeric,   -- ms
  cls              numeric,
  speed_index      numeric,   -- ms
  tti              numeric,   -- ms
  fully_loaded     numeric,   -- ms
  page_bytes       numeric,
  page_requests    numeric,
  error            text,
  created_at       timestamptz not null default now(),
  updated_at       timestamptz not null default now()
);
create index if not exists results_date_idx on results (run_date desc);
create index if not exists results_status_idx on results (status);

-- Lock tables down: the app only talks to Supabase server-side with the service-role key.
alter table monitored_urls enable row level security;
alter table runs enable row level security;
alter table results enable row level security;
alter table url_changes enable row level security;

-- Seed: current Shop LC pages (same URLs + Chicago test location as the original VGL monitor)
insert into monitored_urls (page_type, url, location, sort) values
 ('Home',               'https://www.shoplc.com/', 'Chicago, IL, USA', 1),
 ('Product / PDP',      'https://www.shoplc.com/products/luxuriant-lab-grown-diamond-classic-soiltaire-ring-in-sterling-silver?variant=52279192060217', 'Chicago, IL, USA', 2),
 ('Category / PLP',     'https://www.shoplc.com/collections/rings', 'Chicago, IL, USA', 3),
 ('RA Auction / PLP',   'https://www.shoplc.com/pages/online-auctions-ra', 'Chicago, IL, USA', 4),
 ('RA Auction / Landing','https://www.shoplc.com/pages/online-auctions-tsl', 'Chicago, IL, USA', 5),
 ('RA Auction / PDP',   'https://www.shoplc.com/pages/online-auctions-ra?sort=enddate&sortorder=1', 'Chicago, IL, USA', 6),
 ('Funnel / Cart',      'https://www.shoplc.com/cart', 'Chicago, IL, USA', 7),
 ('Funnel / Checkout',  'https://www.shoplc.com/cart', 'Chicago, IL, USA', 8);
