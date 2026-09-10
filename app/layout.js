import "./globals.css";

export const metadata = {
  title: "ShopLC Performance",
  description: "Storefront performance tracking, refreshed from GTmetrix runs.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
