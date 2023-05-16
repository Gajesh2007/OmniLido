const hre = require("hardhat");

async function main() {
  let lzEndpoint = "";
  let stargateRouter = "";
  let dstChainId = "";
  let srcPoolId = "";
  let dstPoolId = "";
  let destination = "";
  let stargateEthVault = "";
  
  const Source = await hre.ethers.getContractFactory("Source");
  const source = await Source.deploy(
    lzEndpoint,
    stargateRouter,
    destination,
    dstChainId,
    srcPoolId,
    dstPoolId,
    stargateEthVault
  );

  await source.deployed();

  console.log(
    `Deployed The Contract on Source Chain: ${source.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
