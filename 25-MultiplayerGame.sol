// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 1️⃣ Inherit from the Multiplayer Game
// 2️⃣ Call the parent joinGame() function
// HINT: you might have to use the super keyword
// 3️⃣ Increment playerCount in joinGame() function

// MultiplayerGame contract

contract MultiplayerGame {
mapping(address => bool) public players;
function JoinGame() public virtual{
    players[msg.sender] = true;
	}

}

contract Game is MultiplayerGame {

string public gameName;
uint public playerCount;

constructor(string memory _gameName){
	gameName = _gameName;
	playerCount = 0;
}

function JoinGame() public override {
	super.JoinGame(); // function from parent 
	playerCount++;
	}

function StartGame() public {
	}

}
