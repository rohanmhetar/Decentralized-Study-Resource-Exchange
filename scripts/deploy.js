const hre = require("hardhat");

async function main() {
  const DSREToken = await hre.ethers.getContractFactory("DSREToken");
  const dsreToken = await DSREToken.deploy(1000000);
  await dsreToken.deployed();
  console.log("DSRE Token deployed to:", dsreToken.address);

  const StudyResourceNFT = await hre.ethers.getContractFactory("StudyResourceNFT");
  const studyResourceNFT = await StudyResourceNFT.deploy();
  await studyResourceNFT.deployed();
  console.log("StudyResourceNFT deployed to:", studyResourceNFT.address);

  const DSREMarketplace = await hre.ethers.getContractFactory("DSREMarketplace");
  const dsreMarketplace = await DSREMarketplace.deploy(dsreToken.address, studyResourceNFT.address);
  await dsreMarketplace.deployed();
  console.log("DSRE Marketplace deployed to:", dsreMarketplace.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
