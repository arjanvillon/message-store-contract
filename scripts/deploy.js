// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const MessageStore = await hre.ethers.getContractFactory("MessageStore");
  const messageStore = await MessageStore.deploy("Hello World", 1);

  await messageStore.deployed();
  console.log(`MessageStore contract deployed at ${messageStore.address}`);

  const data = await messageStore.viewData();
  console.log(`DATA: ${data}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
