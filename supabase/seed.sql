-- Loads the check-ins logged so far (19-23 Nov 2026).
-- Run AFTER schema.sql and AFTER you have created your login (Authentication > Users > Add user).
-- It attaches the rows to the first user in the project, which should be you.

with me as (select id from auth.users order by created_at limit 1)
insert into public.checkins (user_id, date, bed, wake, walk_min, gym, gym_note, sweets, poison, mood, note)
select me.id, v.date, v.bed, v.wake, v.walk_min, v.gym, v.gym_note, v.sweets, v.poison, v.mood, v.note
from me, (values
  ('2026-11-19'::date, null::time,   null::time,   0,    true,  'Leg press, pull-back, cycling 10 min. First session since surgery, at 6pm.', null,   'brief', null::smallint, 'Looked briefly, shorter than usual.'),
  ('2026-11-20'::date, '23:15'::time,'06:00'::time,null, false, 'Skipped, dinner party in the evening.', null,   'slip',  4::smallint,    'Morning: woke up reaching for the phone but did not indulge. Slept well. Evening: about 60% above usual during work.'),
  ('2026-11-21'::date, '23:00'::time,'08:00'::time,null, false, 'Day off. Played running sports with friends in the evening, first run since surgery.', 'some', 'clear', 4::smallint, 'Slept well, about 9 hours. Spent the day reading. Sweets were some, not too bad.'),
  ('2026-11-22'::date, '23:30'::time,'06:00'::time,null, null,  null, null,   null,    null::smallint, 'Slept poorly after watching a horror film before bed.'),
  ('2026-11-23'::date, null::time,   null::time,   null, true,  'Squats, leg extension, pushups, plus Airdyne bike cardio. Pushed hard.', null, null, null::smallint, 'Strong session. Sleep was good. Walk, sweets, mood and knee/hip feel not yet reported.')
) as v(date, bed, wake, walk_min, gym, gym_note, sweets, poison, mood, note)
on conflict (user_id, date) do nothing;
