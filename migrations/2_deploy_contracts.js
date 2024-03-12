var safemath = artifacts.require("./safemath.sol");
var zombiefactory = artifacts.require("./zombiefactory.sol");
var zombiefeeding = artifacts.require("./zombiefeeding.sol");
var zombiehelper = artifacts.require("./zombiehelper.sol");
var zombieattack = artifacts.require("./zombieattack.sol");
var zombieownership = artifacts.require("./zombieownership.sol");
var METoken = artifacts.require("METoken");
var METFaucet= artifacts.require("METFaucet");

module.exports = function(deployer, network, accounts) {

    var owner= accounts[0];

    deployer.deploy(METoken, {from: owner}).then(function() {

        return  deployer.deploy(METFaucet, METoken.address, owner);

    });

    deployer.deploy(safemath);
    deployer.deploy(zombiefactory);
    deployer.deploy(zombiefeeding);
    deployer.deploy(zombiehelper);
    deployer.deploy(zombieattack);
    deployer.deploy(zombieownership);
}