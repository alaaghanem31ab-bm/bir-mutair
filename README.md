# نظام إدارة البئر – بئر محمد أحمد مطير
حزمة Next.js + Supabase مرتبطة بعقد قاعدة البيانات الحالي.
تشمل الواجهة: Dashboard, Customers, Meters, Readings, Invoices, Payments, Tanker Owners, Reports/Closing, Settings, Users، وتفاصيل الفاتورة وتخصيصات الدفعات.


## Production hardening
- Added Supabase SSR browser/server clients and Next.js proxy session refresh.
- Added `PRODUCTION.md` deployment and acceptance checklist.
- Added `supabase/PRODUCTION_CHECKLIST.sql` for read-only schema/RLS/function inspection.
- Environment example now uses the current Supabase publishable-key convention.
- No service-role/secret credentials are included.
