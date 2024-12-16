const Crowdfunding = artifacts.require("Crowdfunding");

module.exports = function (deployer) {
  // Deploy the Crowdfunding contract
  deployer.deploy(Crowdfunding);
};
