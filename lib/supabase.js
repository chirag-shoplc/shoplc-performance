import { createClient } from '@supabase/supabase-js';

let client;
export function db() {
  if (!client) {
    const url = process.env.SUPABASE_URL;
    const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
    if (!url || !key) throw new Error('SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY not set');
    client = createClient(url, key, {
      auth: { persistSession: false },
      // Never let Next.js's fetch Data Cache serve a stale copy of a table (it did for /data.js).
      global: { fetch: (input, init = {}) => fetch(input, { ...init, cache: 'no-store' }) },
    });
  }
  return client;
}

export function must({ data, error }) {
  if (error) throw new Error(error.message);
  return data;
}
