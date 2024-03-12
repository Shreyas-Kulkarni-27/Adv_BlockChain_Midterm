// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    uint private randNonce = 0;
    uint public attackVictoryProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce = randNonce + 1;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
    }

    function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
        require(zombies[_targetId].level > 0, "Target zombie does not exist");

        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];

        uint rand = randMod(100);
        if (rand <= attackVictoryProbability) {
            myZombie.winCount = myZombie.winCount + 1;
            myZombie.level = myZombie.level + 1;
            enemyZombie.lossCount = enemyZombie.lossCount + 1;
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.lossCount = myZombie.lossCount + 1;
            enemyZombie.winCount = enemyZombie.winCount + 1;
            _triggerCooldown(myZombie);
        }
    }
}
