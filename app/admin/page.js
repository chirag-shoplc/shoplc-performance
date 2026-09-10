import { cookies } from "next/headers";
import { verifySession, COOKIE_NAME } from "@/lib/auth";
import AdminPanel from "./AdminPanel";

export const dynamic = "force-dynamic";

export default async function AdminPage() {
  const token = cookies().get(COOKIE_NAME)?.value;
  const authed = await verifySession(token);
  return <AdminPanel authed={authed} />;
}
