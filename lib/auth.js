// Signed-cookie auth using Web Crypto (works in Edge middleware and Node routes).
export const COOKIE = 'pm_session';
const MAX_AGE = 60 * 60 * 24 * 14; // 14 days

const enc = new TextEncoder();
const secret = () => process.env.SESSION_SECRET || process.env.ADMIN_PASSWORD || 'dev-secret';

async function sign(value) {
  const key = await crypto.subtle.importKey('raw', enc.encode(secret()), { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']);
  const sig = await crypto.subtle.sign('HMAC', key, enc.encode(value));
  return btoa(String.fromCharCode(...new Uint8Array(sig))).replace(/[+/=]/g, (c) => ({ '+': '-', '/': '_', '=': '' }[c]));
}

function safeEqual(a, b) {
  if (a.length !== b.length) return false;
  let r = 0;
  for (let i = 0; i < a.length; i++) r |= a.charCodeAt(i) ^ b.charCodeAt(i);
  return r === 0;
}

export async function makeSession(role) {
  const exp = Math.floor(Date.now() / 1000) + MAX_AGE;
  const body = `${role}.${exp}`;
  return { value: `${body}.${await sign(body)}`, maxAge: MAX_AGE };
}

/** Returns 'admin' | 'viewer' | null */
export async function readSession(cookieValue) {
  if (!cookieValue) return null;
  const [role, exp, sig] = cookieValue.split('.');
  if (!role || !exp || !sig) return null;
  if (Number(exp) < Date.now() / 1000) return null;
  const expected = await sign(`${role}.${exp}`);
  if (!safeEqual(sig, expected)) return null;
  return role === 'admin' || role === 'viewer' ? role : null;
}

export function roleForPassword(pw) {
  if (!pw) return null;
  if (process.env.ADMIN_PASSWORD && safeEqual(pw, process.env.ADMIN_PASSWORD)) return 'admin';
  if (process.env.SITE_PASSWORD && safeEqual(pw, process.env.SITE_PASSWORD)) return 'viewer';
  return null;
}

/** Role for an API request (cookie). Public viewing allowed when SITE_PASSWORD is not set. */
export async function requestRole(req) {
  const role = await readSession(req.cookies.get(COOKIE)?.value);
  if (role) return role;
  return process.env.SITE_PASSWORD ? null : 'public';
}

export function isAdminPassword(pw) {
  return !!pw && !!process.env.ADMIN_PASSWORD && safeEqual(String(pw), process.env.ADMIN_PASSWORD);
}

export async function isAdminRequest(req) {
  return (await readSession(req.cookies.get(COOKIE)?.value)) === 'admin';
}

export function isCron(req) {
  const s = process.env.CRON_SECRET;
  return !!s && req.headers.get('authorization') === `Bearer ${s}`;
}
