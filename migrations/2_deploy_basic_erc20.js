const BasicERC20 = artifacts.require("BasicERC20");

const totalSupply = 10 ** 8 * 10 ** 7;
const decimals = 5;
const name = "CIU Christian Fellowship";
const symbol = "$CIUCF";

module.exports = function (deployer, network, accounts) {
  deployer.deploy(BasicERC20, totalSupply, decimals, name, symbol, {from: accounts[0]});
};
