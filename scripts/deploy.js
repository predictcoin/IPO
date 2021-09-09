const hre = require("hardhat");

async function main() {
  const IPO = await hre.ethers.getContractFactory("IPO");
  const ipo = await IPO.deploy( parseInt(Date.now()/1000) + 0.05*60*60, parseInt(Date.now()/1000) + 24*60*60 );

  const predictcoin = await hre.ethers.getContractAt( 
    "Predictcoin",
    "0xB2d7b35539A543bbE4c74965488fFE33c6721f0d");
  
  await ipo.deployed();
  await predictcoin.approve(ipo.address, "10000000000000000000000")

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