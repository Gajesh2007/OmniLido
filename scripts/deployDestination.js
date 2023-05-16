const hre = require("hardhat");

async function main() {
    let lzEndpoint = "";
    let stargateRouter = "";
    let lido = "";
    let steth = "";
    let stargateEthVault = "";

    const Destination = await hre.ethers.getContractFactory("Destination");
    const destination = await Destination.deploy(
        lzEndpoint,
        stargateRouter,
        lido,
        steth,
        stargateEthVault
    );

    await destination.deployed();

    console.log(
        `Deployed The Contract on Destination Chain: ${destination.address}`
    );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
