pragma solidity ^0.8.10;

import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract METoken is ERC20 {
    string private constant _name = 'Mastering Ethereum Token';
    string private constant _symbol = 'MET';
    uint8 private constant _decimals = 2;
    uint private constant _initial_supply = 2100000000;

    constructor() ERC20(_name, _symbol)
    {
        _mint(msg.sender, _initial_supply);
    }

    function decimals() public pure override returns(uint8){
        return _decimals;
    }
}

