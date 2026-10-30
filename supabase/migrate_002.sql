-- 002: match the original VGL monitor's UI (page keys, names, run scope) — safe to run more than once
alter table monitored_urls add column if not exists page_key text;
alter table monitored_urls add column if not exists site text not null default 'Shop LC';
alter table monitored_urls add column if not exists name text;
update monitored_urls set page_key = case page_type
  when 'Home' then 'slc_home' when 'Product / PDP' then 'slc_pdp' when 'Category / PLP' then 'slc_plp'
  when 'RA Auction / PLP' then 'slc_ra_plp' when 'RA Auction / Landing' then 'slc_ra_lp'
  when 'RA Auction / PDP' then 'slc_ra_pdp' when 'Funnel / Cart' then 'slc_cart'
  when 'Funnel / Checkout' then 'slc_checkout' end
where page_key is null;
update monitored_urls set name = case page_key
  when 'slc_home' then 'Shop LC — Home' when 'slc_pdp' then 'Shop LC — Tourmaline Ring (PDP)'
  when 'slc_plp' then 'Shop LC — Certified Jewelry (PLP)' when 'slc_ra_plp' then 'Shop LC — RA Auctions (PLP)'
  when 'slc_ra_lp' then 'Shop LC — RA Auctions Landing' when 'slc_ra_pdp' then 'Shop LC — RA Auction (PDP)'
  when 'slc_cart' then 'Shop LC — Cart' when 'slc_checkout' then 'Shop LC — Checkout' end
where name is null;
create unique index if not exists monitored_urls_page_key_idx on monitored_urls (page_key);

alter table runs add column if not exists scope text not null default 'full';
alter table runs add column if not exists devices text not null default 'both';

alter table url_changes add column if not exists page_key text;
alter table url_changes add column if not exists site text;
alter table url_changes add column if not exists page_name text;

-- rotating-target pages (RA Auction PDP) record which lot was actually tested
alter table results add column if not exists resolved_url text;
alter table results add column if not exists resolved_label text;
