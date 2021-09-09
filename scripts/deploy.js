const hre = require("hardhat");

async function main() {
  const IPO = await hre.ethers.getContractFactory("IPO");
  const ipo = await IPO.deploy( parseInt(Date.now()/1000) + 0.05*60*60, parseInt(Date.now()/1000) + 0.5*60*60 );

  console.log("IPO deployed to:", ipo.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });