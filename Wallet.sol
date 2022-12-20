// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Wallet {
  address payable public owner;
  mapping (address => uint256) public balances;

  constructor() public {
    owner = payable(msg.sender);
  }

  function deposit() public payable {
    require(msg.value > 0, "Deposit amount must be greater than 0");
    balances[msg.sender] += msg.value;
  }

  function withdraw(uint256 _amount) public {
    require(_amount > 0, "Withdrawal amount must be greater than 0");
    require(balances[msg.sender] >= _amount, "Insufficient funds");
    balances[msg.sender] -= _amount;
    payable(msg.sender).transfer(_amount);
  }

  function transfer(address _to, uint256 _amount) public {
    require(_to != address(0), "Invalid recipient address");
    require(_amount > 0, "Transfer amount must be greater than 0");
    require(balances[msg.sender] >= _amount, "Insufficient funds");
    balances[msg.sender] -= _amount;
    balances[_to] += _amount;
  }
}