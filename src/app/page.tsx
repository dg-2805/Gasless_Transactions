"use client";

import Link from "next/link";
import { Button } from "@/components/ui/button";
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useAccount } from "wagmi";

export default function Home() {
  const { isConnected } = useAccount();

  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-black text-white">
      <div className="absolute top-4 right-4">
        <ConnectButton />
      </div>

      <div className="text-center">
        <h1 className="text-7xl font-bold mb-4">Aether</h1>
        <p className="text-2xl mb-8">Gasless transactions</p>

        <div>
          <Link href="/transaction-details">
            <Button
              className="rounded-lg bg-white text-black px-5 py-4 transition-colors hover:bg-gray-100"
              disabled={!isConnected}
            >
              Make a transaction
            </Button>
          </Link>
        </div>
      </div>
    </main>
  );
}
