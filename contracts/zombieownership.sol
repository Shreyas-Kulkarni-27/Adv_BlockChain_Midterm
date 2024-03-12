// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./zombiehelper.sol";
import "./erc721.sol";
import "./SafeMath.sol"; // Add this line to import SafeMath

contract ZombieOwnership is ZombieHelper, ERC721 {

    using SafeMath for uint256; // Add this line to use SafeMath for uint256

    mapping(uint256 => address) public approvedZombieTransfer;

    function balanceOf(address _owner) external view override returns (uint256) {
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view override returns (address) {
        return zombieToOwner[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable override {
        // Implement the transfer logic here
        // Make sure to check ownership and handle the transfer
        require(_to != address(0), "Invalid recipient address");
        require(zombieToOwner[_tokenId] == _from, "Not the owner of the zombie");
        require(msg.sender == _from || msg.sender == approvedZombieTransfer[_tokenId], "Not authorized to transfer");

        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable override {
        // Implement the approve logic here
        // Allow _approved to take ownership of the zombie with _tokenId
        require(msg.sender == zombieToOwner[_tokenId], "Not the owner of the zombie");

        approvedZombieTransfer[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }

    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        // Implement the actual transfer logic here
        ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
        ownerZombieCount[_from] = ownerZombieCount[_from].sub(1);
        zombieToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
}
