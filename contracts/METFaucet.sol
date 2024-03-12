// Version of Solidity compiler this program was written for
pragma solidity ^0.8.10;

import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';


// A faucet for ERC20 token MET
contract METFaucet {

	ERC20 public METoken;
	address public METOwner;

	// METFaucet constructor, provide the address of METoken contract and
	// the owner address we will be approved to transferFrom
	constructor (address _METoken, address _METOwner) {

		// Initialize the METoken from the address provided
		METoken = ERC20(_METoken);
		METOwner = _METOwner;
	}

	function withdraw(uint withdraw_amount) public returns (bool) {

    	// Limit withdrawal amount to 10 MET
    	require(withdraw_amount <= 10000);

		// Use the transferFrom function of METoken
		METoken.transferFrom(METOwner, msg.sender, withdraw_amount);
		return true;
    }

	// REJECT any incoming ether; function() obsolete, use receive() instead
	receive() external payable {
    revert("Do not send Ether to this contract.");
}
}
