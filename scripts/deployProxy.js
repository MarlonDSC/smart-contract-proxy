const { ethers, upgrades } = require("hardhat");

async function main() {
    const LandRegistry = await ethers.getContractFactory("LandRegistry");
    const proxy = await upgrades.deployProxy(LandRegistry);
    await proxy.deployed();

    console.log(proxy.address);
}

main();