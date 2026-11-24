# Haziq's Personal Portal

A personal portal in the style of the EPCA internal portal, starting with Health & Fitness
(daily check-ins, 14-day habit grid, sleep chart, log form, health admin list). Data lives in Supabase.
It is a single static page: open `index.html` in a browser, no build step.

## One-time setup

1. **Create a Supabase project** at supabase.com (free tier is fine). Pick the Sydney region.
2. **Create the tables.** In the dashboard open SQL Editor > New query, paste `supabase/schema.sql`, and run it.
3. **Create your login.** Authentication > Users > Add user. Enter your email and a strong password,
   and tick "Auto Confirm User".
4. **Turn off public sign-ups.** Authentication > Sign In / Providers > untick "Allow new users to sign up".
   The anon key ends up in the page's code, so this stops strangers making accounts.
5. **Load the check-ins so far.** SQL Editor > New query, paste `supabase/seed.sql`, and run it.
6. **Add your keys.** Copy `config.example.js` to `config.js`. Fill in the Project URL and the
   `anon` public key from Project Settings > API. Never use the `service_role` key.
7. **Open `index.html`** and sign in with the user from step 3.

## How your data is protected

Row Level Security is on for every table, so a signed-in user can only read and write their own rows.
`config.js` is git-ignored, and the repo is private.

## Files

- `index.html` the portal: sidebar nav (Home, Check-ins, Habits, Sleep, Health admin), search (Ctrl/Cmd+K), login.
  Without a `config.js` it runs in local mode and saves to that browser only, so you can try it before Supabase is set up.
- `config.js` your Supabase URL and anon key (you create this, never committed)
- `supabase/schema.sql` tables and security rules
- `supabase/seed.sql` check-ins logged so far
