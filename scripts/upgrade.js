const { ethers, upgrades } = require("hardhat");

// TO DO: Place the address of your proxy here!
const proxyAddress = "0x0d7c934705AF69FeA4373ef79c845510840cCf6d";

async function main() {
    const LandRegistry = await ethers.getContractFactory("LandRegistry");
    const upgraded = await upgrades.upgradeProxy(proxyAddress, LandRegistry);
    // console.log((await upgraded.area()).toString());
    // console.log((await upgraded.perimeter()).toString());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });