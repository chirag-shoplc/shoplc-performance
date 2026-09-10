import { NextResponse } from "next/server";
import { listDayKeys, getDay } from "@/lib/localdata";
import { URLS, WINDOW_DAYS } from "@/lib/urls";

export async function GET() {
  const dateKeys = listDayKeys(WINDOW_DAYS);
  const days = {};
  for (const day of dateKeys) days[day] = getDay(day);
  return NextResponse.json({ dateKeys, days, catalog: URLS });
}
