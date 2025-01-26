import "./globals.css";
import { Inter } from "next/font/google";
import { Providers } from "./providers";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "Aether - Gasless Transactions",
  description: "Make gasless transactions with Aether",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <Providers initialState={undefined}>{children}</Providers>
      </body>
    </html>
  );
}
