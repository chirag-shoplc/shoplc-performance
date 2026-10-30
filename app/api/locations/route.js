import { NextResponse } from 'next/server';
import { requestRole } from '@/lib/auth';
import { listLocations } from '@/lib/gtmetrix';
export const dynamic = 'force-dynamic';

export async function GET(req) {
  if ((await requestRole(req)) !== 'admin') return NextResponse.json({ locations: [] });
  try { return NextResponse.json({ locations: await listLocations() }); }
  catch { return NextResponse.json({ locations: [] }); }
}
