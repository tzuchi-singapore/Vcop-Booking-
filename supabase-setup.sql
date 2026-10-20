-- ============================================================
--  VCOP JOB BOOKING APP (JBA) — Supabase setup
--  Run in Supabase → SQL Editor → New query → Run.
--  Safe to run again; uses IF NOT EXISTS everywhere.
-- ============================================================

-- 1) REQUESTERS (project planners / project managers who raise jobs)
create table if not exists requesters (
  id text primary key,
  username text unique not null,
  password text not null,
  name text not null,
  initials text,
  phone text,
  email text,
  created_at timestamptz default now()
);

-- 2) JOBS (one Project Summary / job request)
create table if not exists jobs (
  id text primary key,
  requester_id text references requesters(id) on delete cascade,
  requester_name text,
  requester_initials text,
  requester_phone text,
  project_title text not null,
  project_address text,
  job_type text,
  site_contact text,
  site_contact_no text,
  sales_pic text,
  requested_date text,        -- YYYY-MM-DD
  requested_time text,        -- HH:MM
  pos text,                   -- JSON array of PO line items
  do_prep text,               -- DO preparation / quotation no.
  return_goods text,
  disposal text,
  special_instructions text,
  attachments text,           -- JSON array {name,type,kind,url|data}
  assigned_pm text,
  assigned_team text,
  manpower text,
  admin_notes text,
  scheduled_date text,
  scheduled_time text,
  status text default 'submitted',   -- submitted | assigned | completed
  signature text,             -- base64 PNG sign-off
  signed_by text,
  created_at timestamptz default now()
);

-- 3) BLOCKS (no delivery / installation days)
create table if not exists blocks (
  id text primary key,
  date text not null,
  time text,
  created_at timestamptz default now()
);

-- 4) RESOURCES (installation teams + project managers)
create table if not exists resources (
  id text primary key,
  kind text not null,         -- 'team' | 'pm'
  name text not null
);

-- Row Level Security (app gates access via login + admin password)
alter table requesters enable row level security;
alter table jobs       enable row level security;
alter table blocks     enable row level security;
alter table resources  enable row level security;

create policy "anon all requesters" on requesters for all using (true) with check (true);
create policy "anon all jobs"       on jobs       for all using (true) with check (true);
create policy "anon all blocks"     on blocks     for all using (true) with check (true);
create policy "anon all resources"  on resources  for all using (true) with check (true);

-- ============================================================
-- 5) STORAGE BUCKET for attachments (layout plans, drawings, 3D, Excel)
--    Big files (the 1–2 MB+ PDFs) are uploaded here, not into the DB.
-- ============================================================
insert into storage.buckets (id, name, public)
values ('attachments','attachments', true)
on conflict (id) do nothing;

-- allow the anon key to upload to and read the attachments bucket
create policy "attachments read"   on storage.objects for select using (bucket_id = 'attachments');
create policy "attachments insert" on storage.objects for insert with check (bucket_id = 'attachments');
create policy "attachments update" on storage.objects for update using (bucket_id = 'attachments');
create policy "attachments delete" on storage.objects for delete using (bucket_id = 'attachments');

-- ============================================================
-- 6) Seed: one requester + the 3 installation teams + PMs
-- ============================================================
insert into requesters (id, username, password, name, initials, phone, email)
values ('seed-demo','demo','demo123','Demo Requester','PM','+65 9000 0000','demo@vcop.com.sg')
on conflict (id) do nothing;

insert into resources (id, kind, name) values
  ('team-a','team','Team A'),
  ('team-b','team','Team B'),
  ('team-c','team','Team C'),
  ('pm-1','pm','PM 1'),
  ('pm-2','pm','PM 2')
on conflict (id) do nothing;
