import { ethers } from "hardhat";

async function main() {
  const GaslessForwarder = await ethers.getContractFactory("GaslessForwarder");
  const forwarder = await GaslessForwarder.deploy();

  await forwarder.deployed();

  console.log("GaslessForwarder deployed to:", forwarder.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});