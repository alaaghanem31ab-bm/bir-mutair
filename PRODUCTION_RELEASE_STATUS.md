# Production Release Status — نظام إدارة البئر – بئر محمد أحمد مطير

## PASS (verified directly)
- Supabase project is reachable through the connected database tooling.
- 42 public tables are present.
- 21 public functions are present.
- 70 public RLS policies are present.
- 36 public tables have RLS enabled.
- Core financial RPCs exist for reading, approval, invoice issuance, payment collection, payment cancellation, and billing-period close/reopen.
- Core financial persistence tables include readings, invoices, payments, payment allocations, receipts, billing periods, pricing history, and audit logs.
- No direct `.insert()`, `.update()`, `.upsert()`, or `.delete()` financial writes were found in the current Next.js application source; the financial write layer is centralized in `lib/financial-rpcs.ts`.
- `anon` EXECUTE was revoked for `bm_close_billing_period` and `bm_reopen_billing_period`.

## NOT YET VERIFIED
- `npm ci` / dependency installation: environment timed out, and offline cache was incomplete.
- `npm run typecheck`.
- `npm run build`.
- Browser E2E against authenticated users.
- Full role matrix tests.
- Full financial scenario tests with staging/test records.

## Release decision
Do **not** label this artifact a final production release yet. It is the hardened Production Candidate pending application build and E2E verification.
