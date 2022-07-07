require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require('@openzeppelin/hardhat-upgrades');
require("dotenv").config();

module.exports = {
  solidity: "0.8.2",
  defaultNetwork: "mumbai",
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.MUMBAI_ETHERSCAN_KEY,
    }
  },
  networks: {
    // rinkeby: {
    //   url: process.env.
    // },
    mumbai: {
      // url: process.env.MUMBAI_ALCHEMY_API,
      url: "https://polygon-mumbai.g.alchemy.com/v2/unWRISsrVFI9bp-AxA2enIcP59S9iWDi",
      // accounts: [process.env.MUMBAI_PRIVATE_KEY],
      accounts: ["202dd05cb6a93c99ad5a7a86d5830180881ec1c793bbdec086a6362d22bed1cb"],
    }
  },
  // etherscan: {
  //   apiKey: process.env.ETHERSCAN_KEY
  // }
};
