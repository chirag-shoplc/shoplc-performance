// The dashboard itself is the static page in /public/monitor.html (served at "/").
export const metadata = { title: 'Shop LC Performance Monitor' };
export default function RootLayout({ children }) {
  return (<html lang="en"><body>{children}</body></html>);
}
