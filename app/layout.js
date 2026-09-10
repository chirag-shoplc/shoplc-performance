import "./globals.css";

export const metadata = {
  title: "ShopLC · Campaign page speed",
  description:
    "How quickly ShopLC campaign pages load for shoppers, refreshed from daily GTmetrix runs.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
