require("@nomiclabs/hardhat-waffle");
require('dotenv').config()

const mnemonic = process.env.MNEMONIC;

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity:{
    compilers: [
      {
        version: "0.6.12"
      },
      {
        version: "0.5.17"
      }
    ]
  },
  networks:{
    bscTestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545/",
      chainId: 97,
      accounts: {mnemonic, path: "m/44'/60'/0'/0", inittialIndex: 0, count: 10},
      timeout: 200000
    }
  }
};
