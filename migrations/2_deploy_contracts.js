// migrations/2_deploy_contracts.js
const TransactionManagement = artifacts.require("TransactionManagement");

module.exports = function(deployer) {
  deployer.deploy(TransactionManagement);
};
