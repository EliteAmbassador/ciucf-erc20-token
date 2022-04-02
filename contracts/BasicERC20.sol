// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract BasicERC20 {

  event Transfer (address indexed from, address indexed to, uint256 value);
  event Approval (address indexed owner, address indexed spender, uint256 value);



  constructor(uint _totalSupply, uint _decimals, string) {
    totalSupply_ = _totalSupply;
  }
}
