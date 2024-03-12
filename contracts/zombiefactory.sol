// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Ownable.sol";
import "./SafeMath.sol";

contract ZombieFactory is Ownable {
    using SafeMath for uint256;

    event NewZombie(uint256 zombieId, string name, uint256 dna);

    uint256 public dnaDigits = 16;
    uint256 public dnaModulus = 10**dnaDigits;
    uint256 public cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) public ownerZombieCount;

    function _createZombie(string memory _name, uint256 _dna) internal {
        uint256 id = zombies.length;
        zombies.push(
            Zombie({
                name: _name,
                dna: _dna,
                level: 1,
                readyTime: uint32(block.timestamp + cooldownTime),
                winCount: 0,
                lossCount: 0
            })
        );
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint256) {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0, "You can only create one zombie");
        uint256 randDna = _generateRandomDna(_name);
        randDna = randDna - (randDna % 100);
        _createZombie(_name, randDna);
    }
}
