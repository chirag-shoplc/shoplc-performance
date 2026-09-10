import fs from "fs";
import path from "path";

const DATA_DIR = path.join(process.cwd(), "data");

/** All day keys we have a committed file for, sorted ascending. */
export function listDayKeys(limit) {
  if (!fs.existsSync(DATA_DIR)) return [];
  const days = fs
    .readdirSync(DATA_DIR)
    .filter((f) => f.endsWith(".json"))
    .map((f) => f.replace(/\.json$/, ""))
    .sort();
  return typeof limit === "number" ? days.slice(-limit) : days;
}

/** One day's results, keyed by URL. {} if the file doesn't exist or is invalid. */
export function getDay(day) {
  const p = path.join(DATA_DIR, `${day}.json`);
  if (!fs.existsSync(p)) return {};
  try {
    return JSON.parse(fs.readFileSync(p, "utf8"));
  } catch {
    return {};
  }
}
