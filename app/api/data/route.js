import { NextResponse } from "next/server";
import { listDayKeys, getDay } from "@/lib/blob";
import { URLS, WINDOW_DAYS } from "@/lib/urls";

export const dynamic = "force-dynamic";

export async function GET() {
  try {
    const dateKeys = await listDayKeys(WINDOW_DAYS);
    const days = {};
    for (const day of dateKeys) {
      days[day] = await getDay(day);
    }
    return NextResponse.json({ dateKeys, days, catalog: URLS });
  } catch (err) {
    return NextResponse.json(
      { error: "Could not load data. Has BLOB_READ_WRITE_TOKEN been configured?", detail: String(err) },
      { status: 500 }
    );
  }
}
