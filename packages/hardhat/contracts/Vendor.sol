pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./YourToken.sol";

contract Vendor is Ownable  {

  YourToken yourToken;

  using SafeMath for uint256;

  uint256 public constant tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  event SellTokens(address seller, uint256 amountOfTokens, uint256 soldAmount);

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  //ToDo: create a payable buyTokens() function:
  function buyTokens() payable public {
    uint256 amountOfTokens = msg.value.mul(tokensPerEth);
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  //ToDo: create a sellTokens() function:
  function sellTokens(uint amount) public {
    require(msg.sender.balance >= amount, "Not enouth amount to sell");
    require(yourToken.allowance(msg.sender, address(this)) >= amount, "Approve Token with correct allowance!");
    uint soldAmount = amount.div(tokensPerEth);
    bool sent = yourToken.transferFrom(msg.sender, address(this), amount);
    // require(sent, "Failed to transfer token");
    (bool success, ) = msg.sender.call{value: soldAmount}("");
    emit SellTokens(msg.sender, amount, soldAmount);
  }

  //ToDo: create a withdraw() function that lets the owner, you can 
  function withdraw() public onlyOwner {
    msg.sender.transfer(address(this).balance);
  }

}
