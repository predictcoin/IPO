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
      url: "https://bsc-testnet.web3api.com/v1/Q3SYS628Q7NM9568343JHPK9HBNDRHUZ5K",
      chainId: 97,
      accounts: {mnemonic, path: "m/44'/60'/0'/0", inittialIndex: 0, count: 10},
      timeout: 200000
    },
    bscMainnet: {
      url: "https://bsc-mainnet.web3api.com/v1/Q3SYS628Q7NM9568343JHPK9HBNDRHUZ5K",
      chainId: 56,
      accounts: {mnemonic, path: "m/44'/60'/0'/0", inittialIndex: 0, count: 10},
      timeout: 200000
    }
  }
};
