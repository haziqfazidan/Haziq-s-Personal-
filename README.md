# Haziq's Personal Portal

A personal portal in the style of the EPCA internal portal, starting with Health & Fitness
(daily check-ins, 14-day habit grid, sleep chart, log form, health admin list). Data lives in Supabase.
It is a single static page: open `index.html` in a browser, no build step.

## Setup status

1. Supabase project created and `supabase/schema.sql` applied (tables and row level security are live).
2. `config.js` holds the project URL and publishable key. That key is built to be public; the login and
   row level security protect the data. Never put the `service_role` key in it.
3. **You do:** Authentication > Users > Add user (your email, a strong password, tick "Auto Confirm User").
4. **You do:** Authentication > Sign In / Providers > untick "Allow new users to sign up".
5. Load the check-ins so far with `supabase/seed.sql` (it attaches them to the first user in the project).
6. Open `index.html` and sign in.

## How your data is protected

Row Level Security is on for every table, so a signed-in user can only read and write their own rows.
The repo is private.

## Files

- `index.html` the portal: sidebar nav (Home, Check-ins, Habits, Sleep, Health admin), search (Ctrl/Cmd+K), login.
  If `config.js` is missing or still has placeholders it runs in local mode and saves to that browser only, so you can try it before Supabase is set up.
- `config.js` Supabase URL and publishable key
- `config.example.js` template for pointing the portal at a different project
- `supabase/schema.sql` tables and security rules
- `supabase/seed.sql` check-ins logged so far
