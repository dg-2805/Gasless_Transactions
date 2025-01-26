// Transaction Details Page (src/app/transaction_details/page.tsx)
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";

export default function TransactionDetails() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-black text-white p-6">
      <h1 className="text-4xl font-bold mb-6">Transaction Details</h1>

      {/* Form */}
      <form className="w-full max-w-md space-y-4">
        {/* Recipient Address */}
        <div>
          <label htmlFor="recipient" className="block text-sm font-medium mb-2">
            Recipient Address
          </label>
          <Input
            id="recipient"
            type="text"
            placeholder="Enter recipient's wallet address"
            className="w-full"
          />
        </div>

        {/* Amount */}
        <div>
          <label htmlFor="amount" className="block text-sm font-medium mb-2">
            Amount (ETH)
          </label>
          <Input
            id="amount"
            type="number"
            placeholder="Enter the amount"
            className="w-full"
          />
        </div>

        {/* Transaction Message */}
        <div>
          <label htmlFor="message" className="block text-sm font-medium mb-2">
            Message
          </label>
          <Textarea
            id="message"
            placeholder="Optional: Add a note for the recipient"
            className="w-full"
          />
        </div>

        {/* Send Button */}
        <div className="pt-4">
          <Button className="w-full bg-green-500 hover:bg-green-600 text-black">
            Send
          </Button>
        </div>
      </form>
    </main>
  );
}
