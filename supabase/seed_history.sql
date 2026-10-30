-- OPTIONAL: imports Shop LC history from the original VGL monitor (2026-09-01 → 2026-10-30).
-- Run AFTER schema.sql. Older days carry Performance + LCP only (that is all the original kept); the latest run has every metric.
begin;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-01', 'import', 'done', '2026-09-01T05:00:00Z', '2026-09-01T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-01', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-01T05:30:00Z', '2026-09-01T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 61::numeric, null::numeric, 2010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 74::numeric, null::numeric, 2000::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 67::numeric, null::numeric, 1970::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 2280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 56::numeric, null::numeric, 2560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 83::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-02', 'import', 'done', '2026-09-02T05:00:00Z', '2026-09-02T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-02', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-02T05:30:00Z', '2026-09-02T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 72::numeric, null::numeric, 2000::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 74::numeric, null::numeric, 2120::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 72::numeric, null::numeric, 1780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 82::numeric, null::numeric, 1330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 76::numeric, null::numeric, 1420::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-03', 'import', 'done', '2026-09-03T05:00:00Z', '2026-09-03T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-03', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-03T05:30:00Z', '2026-09-03T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 76::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 91::numeric, null::numeric, 1300::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 65::numeric, null::numeric, 1570::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 67::numeric, null::numeric, 1910::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 57::numeric, null::numeric, 2380::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 66::numeric, null::numeric, 2660::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-04', 'import', 'done', '2026-09-04T05:00:00Z', '2026-09-04T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-04', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-04T05:30:00Z', '2026-09-04T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 60::numeric, null::numeric, 1730::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 66::numeric, null::numeric, 2090::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 2030::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 70::numeric, null::numeric, 1570::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 74::numeric, null::numeric, 1410::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 65::numeric, null::numeric, 2750::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-05', 'import', 'done', '2026-09-05T05:00:00Z', '2026-09-05T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-05', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-05T05:30:00Z', '2026-09-05T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 61::numeric, null::numeric, 1710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 73::numeric, null::numeric, 1920::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 70::numeric, null::numeric, 1380::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 68::numeric, null::numeric, 1750::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 62::numeric, null::numeric, 1540::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 87::numeric, null::numeric, 1330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-06', 'import', 'done', '2026-09-06T05:00:00Z', '2026-09-06T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-06', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-06T05:30:00Z', '2026-09-06T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 68::numeric, null::numeric, 1500::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 83::numeric, null::numeric, 1410::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 72::numeric, null::numeric, 1370::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 59::numeric, null::numeric, 2340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 71::numeric, null::numeric, 1390::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 77::numeric, null::numeric, 1710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-07', 'import', 'done', '2026-09-07T05:00:00Z', '2026-09-07T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-07', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-07T05:30:00Z', '2026-09-07T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 63::numeric, null::numeric, 1790::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 70::numeric, null::numeric, 1470::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 71::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 68::numeric, null::numeric, 1820::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 70::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 80::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-08', 'import', 'done', '2026-09-08T05:00:00Z', '2026-09-08T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-08', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-08T05:30:00Z', '2026-09-08T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 72::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 48::numeric, null::numeric, 2820::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 66::numeric, null::numeric, 1700::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 81::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 76::numeric, null::numeric, 2130::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 57::numeric, null::numeric, 2840::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-09', 'import', 'done', '2026-09-09T05:00:00Z', '2026-09-09T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-09', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-09T05:30:00Z', '2026-09-09T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 68::numeric, null::numeric, 1710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 75::numeric, null::numeric, 1810::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 2070::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 68::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 68::numeric, null::numeric, 2430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-10', 'import', 'done', '2026-09-10T05:00:00Z', '2026-09-10T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-10', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-10T05:30:00Z', '2026-09-10T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 68::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 85::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 63::numeric, null::numeric, 1790::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 1990::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 74::numeric, null::numeric, 2150::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 60::numeric, null::numeric, 2690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-11', 'import', 'done', '2026-09-11T05:00:00Z', '2026-09-11T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-11', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-11T05:30:00Z', '2026-09-11T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 71::numeric, null::numeric, 1890::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 83::numeric, null::numeric, 1730::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 66::numeric, null::numeric, 1620::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 65::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 66::numeric, null::numeric, 2590::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 60::numeric, null::numeric, 2670::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-12', 'import', 'done', '2026-09-12T05:00:00Z', '2026-09-12T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-12', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-12T05:30:00Z', '2026-09-12T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 82::numeric, null::numeric, 1640::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 70::numeric, null::numeric, 1800::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 69::numeric, null::numeric, 1810::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 70::numeric, null::numeric, 1750::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 64::numeric, null::numeric, 2290::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 74::numeric, null::numeric, 2010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-13', 'import', 'done', '2026-09-13T05:00:00Z', '2026-09-13T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-13', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-13T05:30:00Z', '2026-09-13T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 68::numeric, null::numeric, 2040::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 81::numeric, null::numeric, 1810::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 66::numeric, null::numeric, 1690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 72::numeric, null::numeric, 1180::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 73::numeric, null::numeric, 2130::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 89::numeric, null::numeric, 1390::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-14', 'import', 'done', '2026-09-14T05:00:00Z', '2026-09-14T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-14', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-14T05:30:00Z', '2026-09-14T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 72::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 67::numeric, null::numeric, 1830::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 68::numeric, null::numeric, 1290::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 76::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 74::numeric, null::numeric, 1840::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 95::numeric, null::numeric, 1160::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 62::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 58::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 46::numeric, null::numeric, 2020::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 54::numeric, null::numeric, 1760::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-15', 'import', 'done', '2026-09-15T05:00:00Z', '2026-09-15T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-15', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-15T05:30:00Z', '2026-09-15T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 62::numeric, null::numeric, 2010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 91::numeric, null::numeric, 1320::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 71::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 64::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 77::numeric, null::numeric, 1810::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 82::numeric, null::numeric, 1750::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 64::numeric, null::numeric, 1350::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 61::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 48::numeric, null::numeric, 1960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 49::numeric, null::numeric, 1880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-16', 'import', 'done', '2026-09-16T05:00:00Z', '2026-09-16T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-16', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-16T05:30:00Z', '2026-09-16T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 55::numeric, null::numeric, 2070::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 82::numeric, null::numeric, 1670::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 63::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 70::numeric, null::numeric, 1230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 77::numeric, null::numeric, 1750::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 77::numeric, null::numeric, 1910::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 64::numeric, null::numeric, 1260::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 64::numeric, null::numeric, 1050::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 53::numeric, null::numeric, 1660::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 50::numeric, null::numeric, 1900::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-17', 'import', 'done', '2026-09-17T05:00:00Z', '2026-09-17T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-17', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-17T05:30:00Z', '2026-09-17T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 50::numeric, null::numeric, 1960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 51::numeric, null::numeric, 1780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 59::numeric, null::numeric, 1680::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 61::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 54::numeric, null::numeric, 2580::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 87::numeric, null::numeric, 1550::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 58::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 58::numeric, null::numeric, 1510::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 48::numeric, null::numeric, 2010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 53::numeric, null::numeric, 1750::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-18', 'import', 'done', '2026-09-18T05:00:00Z', '2026-09-18T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-18', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-18T05:30:00Z', '2026-09-18T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 56::numeric, null::numeric, 2050::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 71::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 54::numeric, null::numeric, 1920::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 65::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 64::numeric, null::numeric, 2160::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 82::numeric, null::numeric, 1760::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 60::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 60::numeric, null::numeric, 1380::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 49::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 51::numeric, null::numeric, 1920::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-19', 'import', 'done', '2026-09-19T05:00:00Z', '2026-09-19T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-19', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-19T05:30:00Z', '2026-09-19T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 63::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 37::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 54::numeric, null::numeric, 1850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 55::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 76::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 83::numeric, null::numeric, 1760::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 59::numeric, null::numeric, 1540::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 57::numeric, null::numeric, 1510::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 48::numeric, null::numeric, 1990::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 47::numeric, null::numeric, 2090::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-20', 'import', 'done', '2026-09-20T05:00:00Z', '2026-09-20T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-20', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-20T05:30:00Z', '2026-09-20T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 52::numeric, null::numeric, 2040::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 58::numeric, null::numeric, 1920::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 56::numeric, null::numeric, 1710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 56::numeric, null::numeric, 1660::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 79::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 87::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 60::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 61::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 51::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 52::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-21', 'import', 'done', '2026-09-21T05:00:00Z', '2026-09-21T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-21', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-21T05:30:00Z', '2026-09-21T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 50::numeric, null::numeric, 2210::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 57::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 55::numeric, null::numeric, 1820::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 81::numeric, null::numeric, 1640::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 83::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 59::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 59::numeric, null::numeric, 1370::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 54::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 58::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-22', 'import', 'done', '2026-09-22T05:00:00Z', '2026-09-22T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-22', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-22T05:30:00Z', '2026-09-22T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 53::numeric, null::numeric, 1800::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 61::numeric, null::numeric, 1670::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 55::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 58::numeric, null::numeric, 1550::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 71::numeric, null::numeric, 2010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 81::numeric, null::numeric, 1840::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 56::numeric, null::numeric, 1620::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 59::numeric, null::numeric, 1380::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 50::numeric, null::numeric, 1800::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 52::numeric, null::numeric, 1980::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-23', 'import', 'done', '2026-09-23T05:00:00Z', '2026-09-23T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-23', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-23T05:30:00Z', '2026-09-23T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 58::numeric, null::numeric, 1940::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 64::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 57::numeric, null::numeric, 1640::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 55::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 78::numeric, null::numeric, 1810::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 85::numeric, null::numeric, 1640::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 57::numeric, null::numeric, 1540::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 58::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 47::numeric, null::numeric, 1950::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 50::numeric, null::numeric, 1870::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 59::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-24', 'import', 'done', '2026-09-24T05:00:00Z', '2026-09-24T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-24', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-24T05:30:00Z', '2026-09-24T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 68::numeric, null::numeric, 1250::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 72::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 55::numeric, null::numeric, 1830::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 62::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 80::numeric, null::numeric, 2010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 75::numeric, null::numeric, 2270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 67::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 60::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 55::numeric, null::numeric, 1620::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 49::numeric, null::numeric, 1850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-25', 'import', 'done', '2026-09-25T05:00:00Z', '2026-09-25T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-25', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-25T05:30:00Z', '2026-09-25T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 55::numeric, null::numeric, 2070::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 81::numeric, null::numeric, 1790::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 59::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 59::numeric, null::numeric, 1590::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 76::numeric, null::numeric, 2240::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 72::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 59::numeric, null::numeric, 1350::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 55::numeric, null::numeric, 1800::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 51::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-26', 'import', 'done', '2026-09-26T05:00:00Z', '2026-09-26T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-26', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-26T05:30:00Z', '2026-09-26T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 55::numeric, null::numeric, 1700::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 64::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 1540::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 54::numeric, null::numeric, 1780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 65::numeric, null::numeric, 2970::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 72::numeric, null::numeric, 2450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 70::numeric, null::numeric, 1230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 52::numeric, null::numeric, 1930::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 61::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 81::numeric, null::numeric, 1260::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-27', 'import', 'done', '2026-09-27T05:00:00Z', '2026-09-27T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-27', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-27T05:30:00Z', '2026-09-27T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 54::numeric, null::numeric, 2110::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 73::numeric, null::numeric, 1370::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 57::numeric, null::numeric, 1790::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 63::numeric, null::numeric, 1660::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 79::numeric, null::numeric, 2060::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 71::numeric, null::numeric, 2520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 61::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 62::numeric, null::numeric, 1140::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 69::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 80::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-28', 'import', 'done', '2026-09-28T05:00:00Z', '2026-09-28T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-28', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-28T05:30:00Z', '2026-09-28T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 65::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 65::numeric, null::numeric, 1770::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 57::numeric, null::numeric, 1810::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 62::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 70::numeric, null::numeric, 2580::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 68::numeric, null::numeric, 2820::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 63::numeric, null::numeric, 1470::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 60::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 65::numeric, null::numeric, 1710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 60::numeric, null::numeric, 1750::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-29', 'import', 'done', '2026-09-29T05:00:00Z', '2026-09-29T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-29', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-29T05:30:00Z', '2026-09-29T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 61::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 61::numeric, null::numeric, 2030::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 56::numeric, null::numeric, 1710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 58::numeric, null::numeric, 1580::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 80::numeric, null::numeric, 2020::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 70::numeric, null::numeric, 2590::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 72::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 62::numeric, null::numeric, 1330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 73::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 78::numeric, null::numeric, 1100::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-09-30', 'import', 'done', '2026-09-30T05:00:00Z', '2026-09-30T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-09-30', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-09-30T05:30:00Z', '2026-09-30T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 54::numeric, null::numeric, 1880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 57::numeric, null::numeric, 1850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 62::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 58::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 65::numeric, null::numeric, 3130::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 62::numeric, null::numeric, 3680::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 51::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 72::numeric, null::numeric, 1410::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 81::numeric, null::numeric, 1400::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-01', 'import', 'done', '2026-10-01T05:00:00Z', '2026-10-01T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-01', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-01T05:30:00Z', '2026-10-01T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 62::numeric, null::numeric, 1630::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 56::numeric, null::numeric, 2670::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 55::numeric, null::numeric, 1780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 75::numeric, null::numeric, 2330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 67::numeric, null::numeric, 2870::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 91::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 73::numeric, null::numeric, 1110::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 80::numeric, null::numeric, 1310::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 80::numeric, null::numeric, 1270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 91::numeric, null::numeric, 1260::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'mobile', null::text, 66::numeric, null::numeric, 1240::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-02', 'import', 'done', '2026-10-02T05:00:00Z', '2026-10-02T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-02', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-02T05:30:00Z', '2026-10-02T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 64::numeric, null::numeric, 1570::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 74::numeric, null::numeric, 1920::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 57::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 67::numeric, null::numeric, 1500::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 65::numeric, null::numeric, 3150::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 73::numeric, null::numeric, 2400::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 92::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 87::numeric, null::numeric, 1300::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 92::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 83::numeric, null::numeric, 1240::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 75::numeric, null::numeric, 1320::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'mobile', null::text, 62::numeric, null::numeric, 1470::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-03', 'import', 'done', '2026-10-03T05:00:00Z', '2026-10-03T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-03', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-03T05:30:00Z', '2026-10-03T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 71::numeric, null::numeric, 1670::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 84::numeric, null::numeric, 1250::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 77::numeric, null::numeric, 1510::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 64::numeric, null::numeric, 2000::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 65::numeric, null::numeric, 3190::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 65::numeric, null::numeric, 3220::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 93::numeric, null::numeric, 1240::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 86::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 74::numeric, null::numeric, 1440::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 92::numeric, null::numeric, 1260::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-04', 'import', 'done', '2026-10-04T05:00:00Z', '2026-10-04T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-04', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-04T05:30:00Z', '2026-10-04T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 73::numeric, null::numeric, 1620::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 75::numeric, null::numeric, 1690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 63::numeric, null::numeric, 1680::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 61::numeric, null::numeric, 1980::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 67::numeric, null::numeric, 2960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 70::numeric, null::numeric, 2650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 72::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 87::numeric, null::numeric, 1290::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 80::numeric, null::numeric, 1170::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 81::numeric, null::numeric, 1270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-05', 'import', 'done', '2026-10-05T05:00:00Z', '2026-10-05T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-05', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-05T05:30:00Z', '2026-10-05T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 67::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 87::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 58::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 64::numeric, null::numeric, 3310::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 68::numeric, null::numeric, 2850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-06', 'import', 'done', '2026-10-06T05:00:00Z', '2026-10-06T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-06', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-06T05:30:00Z', '2026-10-06T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 81::numeric, null::numeric, 1620::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 87::numeric, null::numeric, 1220::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 70::numeric, null::numeric, 1930::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 67::numeric, null::numeric, 1500::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 62::numeric, null::numeric, 3380::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 65::numeric, null::numeric, 3150::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 82::numeric, null::numeric, 1230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 82::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 80::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 86::numeric, null::numeric, 1080::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-07', 'import', 'done', '2026-10-07T05:00:00Z', '2026-10-07T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-07', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-07T05:30:00Z', '2026-10-07T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 63::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 75::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 72::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 67::numeric, null::numeric, 1570::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 66::numeric, null::numeric, 3050::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 68::numeric, null::numeric, 2800::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 90::numeric, null::numeric, 1420::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 85::numeric, null::numeric, 1390::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 78::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 89::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-08', 'import', 'done', '2026-10-08T05:00:00Z', '2026-10-08T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-08', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-08T05:30:00Z', '2026-10-08T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 61::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 85::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 67::numeric, null::numeric, 1510::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 67::numeric, null::numeric, 1400::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 66::numeric, null::numeric, 3030::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 64::numeric, null::numeric, 3280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 76::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 85::numeric, null::numeric, 1330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 71::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 83::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-09', 'import', 'done', '2026-10-09T05:00:00Z', '2026-10-09T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-09', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-09T05:30:00Z', '2026-10-09T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 74::numeric, null::numeric, 1640::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 79::numeric, null::numeric, 1620::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 71::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 57::numeric, null::numeric, 1820::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 62::numeric, null::numeric, 3430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 65::numeric, null::numeric, 3230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 59::numeric, null::numeric, 2320::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 79::numeric, null::numeric, 1850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 72::numeric, null::numeric, 1470::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 74::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-10', 'import', 'done', '2026-10-10T05:00:00Z', '2026-10-10T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-10', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-10T05:30:00Z', '2026-10-10T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 64::numeric, null::numeric, 2160::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 84::numeric, null::numeric, 1200::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 46::numeric, null::numeric, 8780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 65::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 82::numeric, null::numeric, 1920::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 79::numeric, null::numeric, 2010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 69::numeric, null::numeric, 2110::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 75::numeric, null::numeric, 2080::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 67::numeric, null::numeric, 1590::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 89::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-11', 'import', 'done', '2026-10-11T05:00:00Z', '2026-10-11T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-11', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-11T05:30:00Z', '2026-10-11T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 79::numeric, null::numeric, 1670::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 72::numeric, null::numeric, 1700::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 63::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 65::numeric, null::numeric, 1330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 72::numeric, null::numeric, 2520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 71::numeric, null::numeric, 2600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 91::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 87::numeric, null::numeric, 1250::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 87::numeric, null::numeric, 1320::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 63::numeric, null::numeric, 2020::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 64::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'mobile', null::text, 86::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-12', 'import', 'done', '2026-10-12T05:00:00Z', '2026-10-12T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-12', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-12T05:30:00Z', '2026-10-12T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 71::numeric, null::numeric, 1230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 81::numeric, null::numeric, 1230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 68::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 71::numeric, null::numeric, 2610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2500::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 91::numeric, null::numeric, 1330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 86::numeric, null::numeric, 1330::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 74::numeric, null::numeric, 1420::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 82::numeric, null::numeric, 1270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 93::numeric, null::numeric, 1240::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-13', 'import', 'done', '2026-10-13T05:00:00Z', '2026-10-13T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-13', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-13T05:30:00Z', '2026-10-13T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 73::numeric, null::numeric, 1730::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 77::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 1700::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 63::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 76::numeric, null::numeric, 2110::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 92::numeric, null::numeric, 1300::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 88::numeric, null::numeric, 1200::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 74::numeric, null::numeric, 1350::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 83::numeric, null::numeric, 1300::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 80::numeric, null::numeric, 1370::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-14', 'import', 'done', '2026-10-14T05:00:00Z', '2026-10-14T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-14', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-14T05:30:00Z', '2026-10-14T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 75::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 82::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 66::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 66::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 71::numeric, null::numeric, 2570::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 84::numeric, null::numeric, 1424::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 81::numeric, null::numeric, 1231::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 32::numeric, null::numeric, 10522::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 69::numeric, null::numeric, 2180::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-15', 'import', 'done', '2026-10-15T05:00:00Z', '2026-10-15T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-15', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-15T05:30:00Z', '2026-10-15T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 66::numeric, null::numeric, 1450::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 85::numeric, null::numeric, 1690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 64::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 67::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 72::numeric, null::numeric, 2530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 70::numeric, null::numeric, 2630::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 84::numeric, null::numeric, 2000::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 80::numeric, null::numeric, 1770::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 80::numeric, null::numeric, 1120::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 80::numeric, null::numeric, 1370::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 85::numeric, null::numeric, 900::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 94::numeric, null::numeric, 1290::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 31::numeric, null::numeric, 10780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 18::numeric, null::numeric, 2950::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 69::numeric, null::numeric, 2230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-16', 'import', 'done', '2026-10-16T05:00:00Z', '2026-10-16T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-16', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-16T05:30:00Z', '2026-10-16T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 77::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 68::numeric, null::numeric, 1840::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 1680::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 68::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 63::numeric, null::numeric, 3270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 60::numeric, null::numeric, 4000::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 69::numeric, null::numeric, 2120::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 64::numeric, null::numeric, 1950::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 76::numeric, null::numeric, 1290::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 91::numeric, null::numeric, 1390::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 81::numeric, null::numeric, 1290::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 87::numeric, null::numeric, 1350::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 29::numeric, null::numeric, 15660::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 9::numeric, null::numeric, 13880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-17', 'import', 'done', '2026-10-17T05:00:00Z', '2026-10-17T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-17', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-17T05:30:00Z', '2026-10-17T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 72::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 75::numeric, null::numeric, 1780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 71::numeric, null::numeric, 1630::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 68::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 65::numeric, null::numeric, 3080::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 62::numeric, null::numeric, 3530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 70::numeric, null::numeric, 1970::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 77::numeric, null::numeric, 1970::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 76::numeric, null::numeric, 1400::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 81::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 93::numeric, null::numeric, 1270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 94::numeric, null::numeric, 1130::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 41::numeric, null::numeric, 2410::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 34::numeric, null::numeric, 4560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-18', 'import', 'done', '2026-10-18T05:00:00Z', '2026-10-18T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-18', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-18T05:30:00Z', '2026-10-18T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 70::numeric, null::numeric, 1830::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 76::numeric, null::numeric, 1690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 60::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 70::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 64::numeric, null::numeric, 3270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 91::numeric, null::numeric, 1350::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 76::numeric, null::numeric, 1200::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 96::numeric, null::numeric, 1180::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 38::numeric, null::numeric, 2880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 59::numeric, null::numeric, 2520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 81::numeric, null::numeric, 2100::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 78::numeric, null::numeric, 1850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 70::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 91::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-19', 'import', 'done', '2026-10-19T05:00:00Z', '2026-10-19T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-19', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-19T05:30:00Z', '2026-10-19T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 75::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 79::numeric, null::numeric, 1690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 66::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 63::numeric, null::numeric, 3340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 64::numeric, null::numeric, 3150::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 84::numeric, null::numeric, 1980::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 79::numeric, null::numeric, 1830::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 81::numeric, null::numeric, 1350::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 77::numeric, null::numeric, 1310::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 76::numeric, null::numeric, 1260::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 96::numeric, null::numeric, 1010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 30::numeric, null::numeric, 6480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 31::numeric, null::numeric, 5200::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 61::numeric, null::numeric, 2250::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-20', 'import', 'done', '2026-10-20T05:00:00Z', '2026-10-20T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-20', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-20T05:30:00Z', '2026-10-20T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 69::numeric, null::numeric, 1620::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 77::numeric, null::numeric, 1670::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 62::numeric, null::numeric, 1500::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 64::numeric, null::numeric, 1510::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 63::numeric, null::numeric, 2960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 64::numeric, null::numeric, 3140::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 72::numeric, null::numeric, 2100::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 78::numeric, null::numeric, 1910::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 69::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 82::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 72::numeric, null::numeric, 1270::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 98::numeric, null::numeric, 960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 32::numeric, null::numeric, 5020::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 32::numeric, null::numeric, 4660::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-21', 'import', 'done', '2026-10-21T05:00:00Z', '2026-10-21T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-21', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-21T05:30:00Z', '2026-10-21T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 77::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 83::numeric, null::numeric, 1380::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 67::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 65::numeric, null::numeric, 1540::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 65::numeric, null::numeric, 2880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 62::numeric, null::numeric, 2960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 86::numeric, null::numeric, 1880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 79::numeric, null::numeric, 1780::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 74::numeric, null::numeric, 1430::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 92::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-22', 'import', 'done', '2026-10-22T05:00:00Z', '2026-10-22T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-22', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-22T05:30:00Z', '2026-10-22T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 73::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 77::numeric, null::numeric, 1700::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 65::numeric, null::numeric, 1390::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 63::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 88::numeric, null::numeric, 1380::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 72::numeric, null::numeric, 2540::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 67::numeric, null::numeric, 2170::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 78::numeric, null::numeric, 1880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 79::numeric, null::numeric, 1040::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 78::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-23', 'import', 'done', '2026-10-23T05:00:00Z', '2026-10-23T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-23', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-23T05:30:00Z', '2026-10-23T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 75::numeric, null::numeric, 1540::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 62::numeric, null::numeric, 1790::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 61::numeric, null::numeric, 1690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 63::numeric, null::numeric, 1610::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 68::numeric, null::numeric, 2290::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 65::numeric, null::numeric, 3040::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 73::numeric, null::numeric, 1960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 80::numeric, null::numeric, 1700::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 72::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 83::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 78::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 85::numeric, null::numeric, 990::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 33::numeric, null::numeric, 4680::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 30::numeric, null::numeric, 5050::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', null::text, 69::numeric, null::numeric, 2190::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'mobile', 'B'::text, 78::numeric, 92::numeric, 1860::numeric, 1220::numeric, 1680::numeric, 63::numeric, 0.178544::numeric, 3170::numeric, 31380::numeric, 3397386::numeric, 373::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-24', 'import', 'done', '2026-10-24T05:00:00Z', '2026-10-24T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-24', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-24T05:30:00Z', '2026-10-24T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 67::numeric, null::numeric, 1950::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 80::numeric, null::numeric, 1590::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 66::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 67::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 63::numeric, null::numeric, 2890::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 76::numeric, null::numeric, 2230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 61::numeric, null::numeric, 2040::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 80::numeric, null::numeric, 1710::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 73::numeric, null::numeric, 1350::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 90::numeric, null::numeric, 1400::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 84::numeric, null::numeric, 1220::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 81::numeric, null::numeric, 1200::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 30::numeric, null::numeric, 5880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 32::numeric, null::numeric, 5150::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-25', 'import', 'done', '2026-10-25T05:00:00Z', '2026-10-25T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-25', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-25T05:30:00Z', '2026-10-25T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 73::numeric, null::numeric, 1760::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 74::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 64::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 75::numeric, null::numeric, 1400::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 66::numeric, null::numeric, 2850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2690::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 66::numeric, null::numeric, 1940::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 65::numeric, null::numeric, 1740::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 75::numeric, null::numeric, 1490::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 88::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 78::numeric, null::numeric, 1140::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 96::numeric, null::numeric, 1010::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 33::numeric, null::numeric, 4950::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 32::numeric, null::numeric, 4920::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-26', 'import', 'done', '2026-10-26T05:00:00Z', '2026-10-26T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-26', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-26T05:30:00Z', '2026-10-26T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 63::numeric, null::numeric, 1630::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 65::numeric, null::numeric, 2140::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 60::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 75::numeric, null::numeric, 1360::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 66::numeric, null::numeric, 2760::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 71::numeric, null::numeric, 2560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 69::numeric, null::numeric, 2060::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 79::numeric, null::numeric, 1850::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 87::numeric, null::numeric, 1370::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 82::numeric, null::numeric, 1400::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-27', 'import', 'done', '2026-10-27T05:00:00Z', '2026-10-27T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-27', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-27T05:30:00Z', '2026-10-27T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 60::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 64::numeric, null::numeric, 1870::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 66::numeric, null::numeric, 1440::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 65::numeric, null::numeric, 3120::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 69::numeric, null::numeric, 2800::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 86::numeric, null::numeric, 1860::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 81::numeric, null::numeric, 1720::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 84::numeric, null::numeric, 1340::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 85::numeric, null::numeric, 1260::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 75::numeric, null::numeric, 1230::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 89::numeric, null::numeric, 1500::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 32::numeric, null::numeric, 4960::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 56::numeric, null::numeric, 2280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PDP', 'desktop', 'A'::text, 88::numeric, 92::numeric, 1670::numeric, 1180::numeric, 1570::numeric, 122::numeric, 0.00869445::numeric, 3270::numeric, 30470::numeric, 3344957::numeric, 364::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-28', 'import', 'done', '2026-10-28T05:00:00Z', '2026-10-28T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-28', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-28T05:30:00Z', '2026-10-28T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 62::numeric, null::numeric, 1530::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 80::numeric, null::numeric, 1070::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 62::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 1630::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 63::numeric, null::numeric, 2980::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 60::numeric, null::numeric, 3900::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 65::numeric, null::numeric, 2110::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 80::numeric, null::numeric, 1600::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 80::numeric, null::numeric, 1280::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 80::numeric, null::numeric, 1260::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'desktop', null::text, 91::numeric, null::numeric, 1190::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Cart', 'mobile', null::text, 96::numeric, null::numeric, 930::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'desktop', null::text, 34::numeric, null::numeric, 5030::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Funnel / Checkout', 'mobile', null::text, 33::numeric, null::numeric, 5130::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-29', 'import', 'done', '2026-10-29T05:00:00Z', '2026-10-29T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-29', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-29T05:30:00Z', '2026-10-29T05:30:00Z'
from r, (values
  ('Home', 'desktop', null::text, 66::numeric, null::numeric, 1570::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Home', 'mobile', null::text, 73::numeric, null::numeric, 1560::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'desktop', null::text, 69::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Product / PDP', 'mobile', null::text, 60::numeric, null::numeric, 1650::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'desktop', null::text, 63::numeric, null::numeric, 3020::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('Category / PLP', 'mobile', null::text, 76::numeric, null::numeric, 2150::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'desktop', null::text, 72::numeric, null::numeric, 1880::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / PLP', 'mobile', null::text, 84::numeric, null::numeric, 1520::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'desktop', null::text, 73::numeric, null::numeric, 1460::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric),
  ('RA Auction / Landing', 'mobile', null::text, 81::numeric, null::numeric, 1480::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric, null::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

with r as (insert into runs (run_date, triggered_by, status, created_at, finished_at) values ('2026-10-30', 'import', 'done', '2026-10-30T05:00:00Z', '2026-10-30T05:30:00Z') returning id)
insert into results (run_id, url_id, run_date, page_type, url, device, location, status, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests, created_at, updated_at)
select r.id, u.id, '2026-10-30', u.page_type, u.url, v.device, u.location, 'completed', v.grade, v.performance, v.structure, v.lcp, v.fcp, v.speed_index, v.tbt, v.cls, v.tti, v.fully_loaded, v.page_bytes, v.page_requests, '2026-10-30T05:30:00Z', '2026-10-30T05:30:00Z'
from r, (values
  ('Home', 'desktop', 'C'::text, 64::numeric, 84::numeric, 1390::numeric, 1390::numeric, 1540::numeric, 776::numeric, 0::numeric, 13180::numeric, 32100::numeric, 4729078::numeric, 404::numeric),
  ('Home', 'mobile', 'C'::text, 73::numeric, 89::numeric, 1580::numeric, 1580::numeric, 1750::numeric, 318::numeric, 0::numeric, 11970::numeric, 31300::numeric, 4362076::numeric, 409::numeric),
  ('Product / PDP', 'desktop', 'C'::text, 66::numeric, 88::numeric, 1480::numeric, 1480::numeric, 1720::numeric, 532::numeric, 0::numeric, 8480::numeric, 28390::numeric, 4414505::numeric, 420::numeric),
  ('Category / PLP', 'desktop', 'C'::text, 66::numeric, 87::numeric, 2880::numeric, 2550::numeric, 2840::numeric, 144::numeric, 0.0131517::numeric, 4300::numeric, 29260::numeric, 4540334::numeric, 395::numeric),
  ('Category / PLP', 'mobile', 'C'::text, 66::numeric, 84::numeric, 2870::numeric, 2650::numeric, 3060::numeric, 120::numeric, 0.014455::numeric, 3730::numeric, 32680::numeric, 4655677::numeric, 398::numeric),
  ('RA Auction / PLP', 'desktop', 'B'::text, 73::numeric, 91::numeric, 2090::numeric, 1260::numeric, 1850::numeric, 284::numeric, 0.00869445::numeric, 11830::numeric, 30190::numeric, 3512730::numeric, 368::numeric),
  ('RA Auction / PLP', 'mobile', 'B'::text, 78::numeric, 92::numeric, 1940::numeric, 1220::numeric, 1720::numeric, 65::numeric, 0.178544::numeric, 3230::numeric, 30160::numeric, 3439329::numeric, 369::numeric),
  ('RA Auction / Landing', 'desktop', 'C'::text, 74::numeric, 86::numeric, 1270::numeric, 1270::numeric, 1370::numeric, 437::numeric, 0.0245129::numeric, 11930::numeric, 30360::numeric, 3512730::numeric, 359::numeric),
  ('RA Auction / Landing', 'mobile', 'B'::text, 80::numeric, 90::numeric, 1490::numeric, 1490::numeric, 1620::numeric, 232::numeric, 0.050534::numeric, 10820::numeric, 30240::numeric, 3386900::numeric, 358::numeric),
  ('Funnel / Cart', 'desktop', 'B'::text, 83::numeric, 93::numeric, 1280::numeric, 1010::numeric, 1790::numeric, 260::numeric, 0.00219932::numeric, 10850::numeric, 20130::numeric, 3303014::numeric, 346::numeric),
  ('Funnel / Cart', 'mobile', 'A'::text, 96::numeric, 93::numeric, 1140::numeric, 810::numeric, 1410::numeric, 36::numeric, 0.0133795::numeric, 1600::numeric, 17030::numeric, 3261071::numeric, 342::numeric),
  ('Funnel / Checkout', 'desktop', 'E'::text, 36::numeric, 76::numeric, 2900::numeric, 2190::numeric, 5700::numeric, 2176::numeric, 0.0065182::numeric, 10450::numeric, 38750::numeric, 5389681::numeric, 538::numeric),
  ('Funnel / Checkout', 'mobile', 'F'::text, 33::numeric, 73::numeric, 4710::numeric, 1580::numeric, 5270::numeric, 2423::numeric, 0.0232291::numeric, 9820::numeric, 28110::numeric, 5756682::numeric, 537::numeric)
) as v(page_type, device, grade, performance, structure, lcp, fcp, speed_index, tbt, cls, tti, fully_loaded, page_bytes, page_requests)
join monitored_urls u on u.page_type = v.page_type;

commit;
