import { db, must } from './supabase';

/** Small key/value settings stored in Supabase (table `settings`). */
export async function getSetting(key, fallback) {
  try {
    const rows = must(await db().from('settings').select('value').eq('key', key).limit(1));
    return rows.length ? rows[0].value : fallback;
  } catch (e) {
    console.error('getSetting ' + key + ': ' + e.message);
    return fallback;
  }
}

export async function setSetting(key, value) {
  must(await db().from('settings').upsert({ key, value, updated_at: new Date().toISOString() }));
}
