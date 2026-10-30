import { NextResponse } from 'next/server';
import { COOKIE, makeSession, roleForPassword } from '@/lib/auth';

export async function POST(req) {
  const { password } = await req.json().catch(() => ({}));
  const role = roleForPassword(password);
  if (!role) return NextResponse.json({ error: 'Wrong password' }, { status: 401 });
  const { value, maxAge } = await makeSession(role);
  const res = NextResponse.json({ role });
  res.cookies.set(COOKIE, value, { httpOnly: true, secure: process.env.NODE_ENV === 'production', sameSite: 'lax', path: '/', maxAge });
  return res;
}
