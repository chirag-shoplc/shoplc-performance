import './globals.css';

export const metadata = { title: 'Shop LC Performance Monitor', description: 'Daily GTmetrix benchmark for Shop LC pages' };

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
