// SPDX-License-Identifier: MIT

// demonstrates use of modifiers

pragma solidity ^0.8.0;

contract PausableToken {
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier onlyOwner() {
      require( msg.sender == owner, "you ae not the owner");
        _;
    }

    modifier notPaused(){
        require( paused == false, "token transfers are paused");
        _;
    }

    // 2️⃣ Implement the modifier to check if the contract is not paused

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    // 3️⃣ use the notPaused modifier in this function 
    function transfer(address to, uint amount) public notPaused{
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
