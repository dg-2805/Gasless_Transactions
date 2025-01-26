// Home Page (src/app/page.tsx)
import Link from "next/link";
import { Button } from "@/components/ui/button";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-black text-white">
      <div className="absolute top-4 right-4">
        <Button className="bg-green-500 hover:bg-green-600 text-black px-4 py-2 rounded-md">
          Connect Wallet
        </Button>
      </div>

      <div className="text-center">
        <h1 className="text-7xl font-bold mb-4">Aether</h1>
        <p className="text-2xl mb-8">Gasless transactions</p>

        <div>
          {/* Link to Transaction Details page */}
          <Link href="/transaction_details.tsx">
            <Button className="rounded-lg bg-white text-black px-5 py-4 transition-colors hover:bg-gray-100">
              Make a transaction
            </Button>
          </Link>
        </div>
      </div>
    </main>
  );
}
