# Production Verification — نظام إدارة البئر

## Current state
This package is a **Production Candidate**. The Supabase database has been inspected directly and production hardening has been applied to remove anonymous EXECUTE on billing-period close/reopen.

## Verified directly in Supabase
- Public tables: 42
- Public functions: 21
- Public RLS policies: 70
- Tables with RLS enabled: 36
- Core financial RPCs exist: reading, invoice, payment, cancellation, close/reopen.
- Core financial tables exist, including payment allocations and receipts.
- `bm_close_billing_period` and `bm_reopen_billing_period` are SECURITY DEFINER and check manager authorization internally.
- Anonymous EXECUTE on period close/reopen was revoked by migration `harden_production_rpc_execute_grants`.

## Important limitation
A full build was not completed in this environment because npm dependency installation could not finish within the execution window and the packages were not locally cached. Therefore this environment cannot honestly mark `npm run build` as PASS.

A production release should only be tagged PASS after:
1. `npm ci`
2. `npm run typecheck`
3. `npm run build`
4. browser E2E tests against a test/staging dataset
5. authenticated role tests for manager, collector, reader, and reports employee
6. financial scenario tests for reading → invoice → payment allocation → receipt → cancellation → closing/reopening
