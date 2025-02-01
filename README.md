# 🌌 Aether - Gasless Transactions Platform

Aether is a decentralized platform enabling **gasless transactions** for ERC-20 and ERC-721 tokens. Built with **Solidity**, **Hardhat**, **WAGMI**, **RainbowKit**, and **Next.js**, it provides a seamless user experience where users can connect their wallets and send tokens without worrying about gas fees.

---

## ✨ Features

- 🚀 **Gasless Transactions**: Send ERC-20 and ERC-721 tokens without paying gas fees.  
- 🛡️ **Wallet Integration**: Effortlessly connect wallets using WAGMI and RainbowKit.  
- ⚡ **Modern Tech Stack**: Combines Solidity, Hardhat, and Next.js for secure and efficient operations.

---

## 🛠 Prerequisites

Ensure the following are installed:

- [Node.js](https://nodejs.org/) (v16+ recommended)  
- npm or yarn  
- [Git](https://git-scm.com/)

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/dg-2805/Gasless_Transactions.git
cd aether

### 2. Install Dependencies

Run the following command in the project root directory:

```bash
npm install
```

### 3. Configure Environment Variables

Create a `.env` file in the root directory and add the following:

```env
NEXT_PUBLIC_ALCHEMY_API_KEY=your_alchemy_api_key
PRIVATE_KEY=your_wallet_private_key
CONTRACT_ADDRESS=deployed_contract_address
```

### 4. Compile and Deploy Smart Contracts

Navigate to the `contracts` directory and compile the smart contracts:

```bash
npx hardhat compile
```

To deploy the contracts, use:

```bash
npx hardhat run scripts/deploy.js --network <network_name>
```

Replace `<network_name>` with your target blockchain (e.g., `goerli`, `mainnet`, or `polygon`).

Token.sol deployed at:
 ```bash
 0xe5da5a7B250E68eF69d40b9799bede9491C14a67
 ```
NFTcontract.sol deployed at: 
```bash
0x44378e1beefC422568ABa878c74168369e4840C6
```
Forwarder.sol deployed at: 
```bash
0x086C097E6e82CC076828C94d4F433976B69ee56b
```

### 5. Start the Development Server

Run the following command to start the Next.js development server:

```bash
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000) to view the application.

---

## 🧑‍💻 Usage

1. **Connect Wallet**  
   Use the "Connect Wallet" button powered by RainbowKit to connect your wallet.

2. **Select Token Type**  
   Choose whether to send an ERC-20 or ERC-721 token.

3. **Enter Transaction Details**  
   Provide the recipient address and token ID/amount.

4. **Send Gasless Transaction**  
   Click "Send" to initiate the gasless transaction through Aether.

---

## 📂 Project Structure

```plaintext
├── contracts          # Solidity smart contracts
├── scripts            # Deployment and interaction scripts
├── pages              # Next.js pages
├── components         # Reusable UI components
├── styles             # Styling files
├── utils              # Helper functions
└── .env               # Environment variables
```

---

## 🛠 Tech Stack

- **Solidity**: Smart contract programming.
- **Hardhat**: Development and testing framework.
- **Next.js**: Frontend framework.
- **WAGMI & RainbowKit**: Wallet integration and UI.
- **Alchemy**: Blockchain data provider.

---

## 🤝 Contributing

Contributions are welcome!  
Follow these steps to contribute:

1. **Fork the repository**.
2. **Create a new branch** (`git checkout -b feature-name`).
3. **Commit your changes** (`git commit -m 'Add feature'`).
4. **Push to the branch** (`git push origin feature-name`).
5. **Open a pull request**.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 📧 Contact

For queries or support, contact the team at **devayanee999@gmail.com**.
```
