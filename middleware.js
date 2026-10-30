import { NextResponse } from 'next/server';
import { COOKIE, readSession } from '@/lib/auth';

// When SITE_PASSWORD is set, the dashboard page requires login. APIs enforce their own rules.
export async function middleware(req) {
  if (!process.env.SITE_PASSWORD) return NextResponse.next();
  const role = await readSession(req.cookies.get(COOKIE)?.value);
  if (role) return NextResponse.next();
  return NextResponse.redirect(new URL('/login', req.url));
}

export const config = { matcher: ['/'] };
