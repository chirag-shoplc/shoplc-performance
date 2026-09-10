import { listDayKeys, getDay } from "@/lib/blob";
import { URLS, WINDOW_DAYS } from "@/lib/urls";
import Dashboard from "./Dashboard";

export const dynamic = "force-dynamic";

export default async function Page() {
  let dateKeys = [];
  let days = {};
  let error = null;
  try {
    dateKeys = await listDayKeys(WINDOW_DAYS);
    for (const d of dateKeys) days[d] = await getDay(d);
  } catch (err) {
    error = String(err);
  }

  return <Dashboard dateKeys={dateKeys} days={days} catalog={URLS} error={error} />;
}
