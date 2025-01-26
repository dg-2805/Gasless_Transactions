import { ethers } from "ethers";
//import { ethers as hardhatEthers } from "hardhat";

async function main() {
  const MyNFT = new ethers.ContractFactory("MyNFT", [], ethers.getDefaultProvider());
  const nft = await MyNFT.deploy();

  await nft.deployed();

  console.log("MyNFT deployed to:", nft.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});