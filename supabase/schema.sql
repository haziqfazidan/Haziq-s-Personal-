-- Personal portal schema. Run once in Supabase: SQL Editor > New query > paste > Run.

create table if not exists public.checkins (
  user_id    uuid not null default auth.uid() references auth.users (id) on delete cascade,
  date       date not null,
  bed        time,
  wake       time,
  walk_min   integer check (walk_min between 0 and 600),
  gym        boolean,
  gym_note   text,
  sweets     text check (sweets in ('none', 'some', 'lots')),
  poison     text check (poison in ('clear', 'brief', 'slip')),
  mood       smallint check (mood between 1 and 5),
  note       text,
  updated_at timestamptz not null default now(),
  primary key (user_id, date)
);

create table if not exists public.admin_tasks (
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  key     text not null,
  done    boolean not null default false,
  primary key (user_id, key)
);

-- Keep updated_at fresh on every change.
create or replace function public.touch_updated_at() returns trigger
language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

drop trigger if exists checkins_touch on public.checkins;
create trigger checkins_touch before update on public.checkins
  for each row execute function public.touch_updated_at();

-- Row level security: each signed-in user can only see and change their own rows.
-- The anon key sits in the front-end code, so this is what actually protects the data.
alter table public.checkins    enable row level security;
alter table public.admin_tasks enable row level security;

drop policy if exists "own checkins" on public.checkins;
create policy "own checkins" on public.checkins
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

drop policy if exists "own admin tasks" on public.admin_tasks;
create policy "own admin tasks" on public.admin_tasks
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
