// Server-side Supabase helper — use only on the server (API routes, getServerSideProps, server actions)
// Do NOT import this file from client-side code.
import { createClient } from "@supabase/supabase-js";

const supabaseUrl = process.env.SUPABASE_URL || process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  throw new Error("Missing SUPABASE_SERVICE_ROLE_KEY or SUPABASE_URL environment variables for server-side Supabase client");
}

// This client uses the service role key — it has elevated privileges. Keep the key server-side only.
export const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey, {
  // Optional: disable automatic session persistence on the server
  auth: { persistSession: false },
});
