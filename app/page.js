import { listDayKeys, getDay } from "@/lib/localdata";
import { URLS, WINDOW_DAYS } from "@/lib/urls";
import Dashboard from "./Dashboard";

export default function Page() {
  const dateKeys = listDayKeys(WINDOW_DAYS);
  const days = {};
  for (const d of dateKeys) days[d] = getDay(d);

  return <Dashboard dateKeys={dateKeys} days={days} catalog={URLS} error={null} />;
}
