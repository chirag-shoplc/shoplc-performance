-- 003: settings (daily automatic run on/off) — safe to run more than once
create table if not exists settings (
  key        text primary key,
  value      jsonb not null,
  updated_at timestamptz not null default now()
);
alter table settings enable row level security;
insert into settings (key, value) values ('auto_run', 'true') on conflict (key) do nothing;
