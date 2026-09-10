import { NextResponse } from "next/server";
import { cookies } from "next/headers";
import { verifySession, COOKIE_NAME } from "@/lib/auth";
import { saveDay } from "@/lib/blob";

const DAY_RE = /^\d{4}-\d{2}-\d{2}$/;

export async function POST(req) {
  const token = cookies().get(COOKIE_NAME)?.value;
  const authed = await verifySession(token);
  if (!authed) {
    return NextResponse.json({ error: "Not authenticated." }, { status: 401 });
  }

  const body = await req.json().catch(() => null);
  if (!body || typeof body !== "object") {
    return NextResponse.json({ error: "Expected a JSON body." }, { status: 400 });
  }

  const { day, results } = body;
  if (!day || !DAY_RE.test(day)) {
    return NextResponse.json({ error: "Expected a `day` field formatted YYYY-MM-DD." }, { status: 400 });
  }
  if (!results || typeof results !== "object" || Array.isArray(results)) {
    return NextResponse.json({ error: "Expected a `results` object keyed by URL." }, { status: 400 });
  }

  try {
    const merged = await saveDay(day, results);
    return NextResponse.json({ ok: true, day, urlCount: Object.keys(merged).length });
  } catch (err) {
    return NextResponse.json({ error: "Upload failed.", detail: String(err) }, { status: 500 });
  }
}
