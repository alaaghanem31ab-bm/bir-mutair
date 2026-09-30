# Base44 setup notes

## Structure quirk
- Next.js 15 App Router: `app/` directory contains `page.tsx`, `layout.tsx`, `globals.css` (moved from repo root during setup — the repo originally had them at root, which Next cannot boot).

## Running
- `docker compose -f docker-compose.base44.yml up -d` — Next.js 15 dev server on host port 3000, bind-mounted source, `npm install` on startup (no lockfile in repo, so `npm install` not `npm ci`).
- `next.config.js` sets `allowedDevOrigins` from `BASE44_PUBLIC_HOST_SUFFIX` (bare hostname, no scheme — with scheme Next ignores it).

## Env / secrets
- `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_APP_NAME` are in `.env.base44-defaults` (URL is public, from SUPABASE.md; project ref `tvhzwflwytotydhkakrn`).
- `NEXT_PUBLIC_SUPABASE_ANON_KEY` is required at boot (`lib/supabase.ts` throws at import without it). Generated dev placeholder exists; the real value is a user secret from Supabase dashboard → Project Settings → API.
- `SUPABASE_SERVICE_ROLE_KEY` is optional (only used by `lib/supabaseServer.ts`, which nothing imports yet).

## Backend
- This app has no local backend/database — all data lives in the remote hosted Supabase project (tables `bm_*`, RPCs like `dashboard_summary`, `customer_search`). Login uses Supabase auth.

## Verify
- `curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/` → 200.
- Working app shows an Arabic RTL login screen (Supabase auth) unless a session exists.
