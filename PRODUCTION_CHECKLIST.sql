-- Production read-only verification queries.
-- Run from Supabase SQL Editor with an appropriately privileged admin session.

select current_database() as database_name, current_user as database_user;

select count(*) as public_tables
from information_schema.tables
where table_schema='public';

select count(*) as enabled_rls_tables
from pg_tables
where schemaname='public' and rowsecurity;

select count(*) as rls_policies
from pg_policies
where schemaname='public';

select routine_name,
       specific_name,
       routine_type
from information_schema.routines
where routine_schema='public'
  and routine_name in (
    'bm_post_reading',
    'approve_meter_reading',
    'bm_issue_invoice_for_reading',
    'bm_record_payment',
    'bm_record_payment_auto',
    'bm_cancel_payment',
    'bm_close_billing_period',
    'bm_reopen_billing_period'
  )
order by routine_name, specific_name;

select routine_name, grantee, privilege_type
from information_schema.routine_privileges
where routine_schema='public'
  and routine_name in (
    'bm_post_reading',
    'approve_meter_reading',
    'bm_issue_invoice_for_reading',
    'bm_record_payment',
    'bm_record_payment_auto',
    'bm_cancel_payment',
    'bm_close_billing_period',
    'bm_reopen_billing_period'
  )
order by routine_name, grantee;

-- Expected hardening: anon must NOT have EXECUTE on period close/reopen.
select routine_name, grantee, privilege_type
from information_schema.routine_privileges
where routine_schema='public'
  and routine_name in ('bm_close_billing_period','bm_reopen_billing_period')
  and grantee='anon';

-- Verify financial tables exist.
select tablename
from pg_tables
where schemaname='public'
  and tablename in (
    'bm_readings','bm_invoices','bm_payments','bm_payment_allocations',
    'bm_receipts','bm_billing_periods','bm_pricing_history','bm_audit_logs'
  )
order by tablename;
