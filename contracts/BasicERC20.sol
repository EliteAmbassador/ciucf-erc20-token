// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract BasicERC20 {

  event Transfer (address indexed from, address indexed to, uint256 value);
  event Approval (address indexed owner, address indexed spender, uint256 value);

  mapping(address => uint) balances;
  mapping(address => mapping(address => uint)) allowed;

  uint public decimals;
  uint public totalSupply_;

  string public name; //CIU Christian Fellowship
  string public symbol; //CIUCF

  modifier sufficientBalance(address _spender, uint _value){
    require(_value <= balances[_spender], "You have insufficient tokens");
    _;
  }

  modifier sufficientApproval(address _owner, address _spender, uint _value){
    require(_value <= allowed[_owner][_spender], "You have insufficient allowance from owner");
    _;
  }

  modifier validAddress(address _address) {
    require(_address != address(0), "Address is invalid, Please, check your address and try again");
    _;
  }


  constructor(uint _totalSupply, uint _decimals, string memory _name, string memory _symbol) {
    totalSupply_ = _totalSupply;
    decimals = _decimals;
    name = _name;
    symbol = _symbol;

    balances[msg.sender] = totalSupply_;
  }

  function totalSupply() public view virtual returns(uint256){
    return totalSupply_;
  }

  function balanceOf(address _who) public view virtual returns(uint256){
    return balances[_who];
  }

   function transfer(address to, uint256 value) public virtual sufficientBalance(msg.sender, value) validAddress(to) returns(bool){
    balances[msg.sender] = balances[msg.sender] - value;
    balances[to] = balances[to] + value;
    emit Transfer(msg.sender, to, value);

    return true;
  }

  function approve(address spender, uint256 value) public virtual validAddress(spender) returns(bool){
    allowed[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);

    return true;
  }

  function allowance(address owner, address spender) public virtual view returns(uint256){
    return allowed[owner][spender];
  }

  function transferFrom(address from, address to, uint256 value) public virtual sufficientBalance(from, value) sufficientApproval(from, msg.sender, value) validAddress(to) returns(bool){
    allowed[from][msg.sender] = allowed[from][msg.sender] - value; //Reduces the sender's allowance
    balances[from] = balances[from] - value; //Reduces the allocators balance
    balances[to] = balances[to] + value; //Increases the receiver's balance
    emit Transfer(from, to, value);

    return true;
  }
}
