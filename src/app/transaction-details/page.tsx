"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { AlertCircle } from "lucide-react";

export default function TransactionDetails() {
  const [tokenType, setTokenType] = useState<"ERC20" | "ERC721">("ERC20");
  const [recipientAddress, setRecipientAddress] = useState("");
  const [tokenAmount, setTokenAmount] = useState("");
  const [tokenId, setTokenId] = useState("");
  const [transactionStatus, setTransactionStatus] = useState<
    "idle" | "pending" | "success" | "error"
  >("idle");
  const [errorMessage, setErrorMessage] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setTransactionStatus("pending");
    setErrorMessage("");

    // Here you would typically call your contract method to forward the transaction
    // For demonstration, we're using a timeout to simulate the process
    setTimeout(() => {
      // Simulating a successful transaction
      setTransactionStatus("success");
      // In a real implementation, you'd handle errors here as well
    }, 2000);
  };

  return (
    <main className="flex min-h-screen flex-col items-center justify-center bg-black text-white p-6">
      <h1 className="text-4xl font-bold mb-6">Gasless Transaction Details</h1>

      <form onSubmit={handleSubmit} className="w-full max-w-md space-y-4">
        <div>
          <Label htmlFor="tokenType">Token Type</Label>
          <Select
            onValueChange={(value: "ERC20" | "ERC721") => setTokenType(value)}
            defaultValue="ERC20"
          >
            <SelectTrigger className="text-white bg-gray-800">
              <SelectValue placeholder="Select token type" />
            </SelectTrigger>
            <SelectContent className="bg-gray-800 text-white">
              <SelectItem value="ERC20" className="hover:bg-gray-700">
                ERC-20
              </SelectItem>
              <SelectItem value="ERC721" className="hover:bg-gray-700">
                ERC-721
              </SelectItem>
            </SelectContent>
          </Select>
        </div>

        {tokenType === "ERC20" ? (
          <div>
            <Label htmlFor="amount">Amount</Label>
            <Input
              id="amount"
              type="text"
              placeholder="Enter the token amount"
              value={tokenAmount}
              onChange={(e) => setTokenAmount(e.target.value)}
              className="w-full text-white placeholder-gray-400 bg-gray-800"
            />
          </div>
        ) : (
          <div>
            <Label htmlFor="tokenId">Token ID</Label>
            <Input
              id="tokenId"
              type="text"
              placeholder="Enter the token ID"
              value={tokenId}
              onChange={(e) => setTokenId(e.target.value)}
              className="w-full text-white placeholder-gray-400 bg-gray-800"
            />
          </div>
        )}

        <div>
          <Label htmlFor="recipient">Recipient Address</Label>
          <Input
            id="recipient"
            type="text"
            placeholder="Enter recipient's wallet address"
            value={recipientAddress}
            onChange={(e) => setRecipientAddress(e.target.value)}
            className="w-full text-white placeholder-gray-400 bg-gray-800"
          />
        </div>

        <div className="pt-4">
          <Button
            type="submit"
            className="w-full bg-primary text-primary-foreground hover:bg-primary/90"
            disabled={transactionStatus === "pending"}
          >
            {transactionStatus === "pending"
              ? "Processing..."
              : "Send Gasless Transaction"}
          </Button>
        </div>
      </form>

      {transactionStatus === "success" && (
        <Alert className="mt-4 bg-green-500 text-black">
          <AlertCircle className="h-4 w-4" />
          <AlertTitle>Success</AlertTitle>
          <AlertDescription>
            Your transaction has been successfully forwarded!
          </AlertDescription>
        </Alert>
      )}

      {transactionStatus === "error" && (
        <Alert className="mt-4 bg-red-500 text-white">
          <AlertCircle className="h-4 w-4" />
          <AlertTitle>Error</AlertTitle>
          <AlertDescription>
            {errorMessage ||
              "An error occurred while processing your transaction."}
          </AlertDescription>
        </Alert>
      )}
    </main>
  );
}
