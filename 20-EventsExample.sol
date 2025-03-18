
// SPDX-License-Identifier: MIT

    // 1️⃣ Add an event called "NewUserRegistered" with 2 arguments
    // 👉 user as address type
    // 👉 username as string type
    // 2️⃣ Emit the event with msg.sender and username as the inputs
    // this contract is verified and published at etherscan at
    // https://sepolia.etherscan.io/address/0x0197478c3a616269553fdbbc05c1c484bffebe66#code 
    // source - https://academy.nazaweb.com/view/courses/ultimate-solidity-smart-contract-course/2096610-beginner-to-expert-solidity-fundamentals/6601074-20-solidity-events

pragma solidity ^0.8.0;

contract EventExample {

struct User {
	string username;
	uint8 age;
	}

mapping(address => User) public users;

event NewUserRegistered(address indexed user, string username);

function registerUser(string memory _username, uint8 _age) public {
	User storage newUser = users[msg.sender];
	newUser.username = _username;
	newUser.age = _age;

	emit NewUserRegistered(msg.sender, _username);
	} 
}