pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20 {

    constructor(uint initialSupply) ERC20("Your Token", "YTK") public {
        _mint(msg.sender,  initialSupply * 10 ** 18);
    }
}
