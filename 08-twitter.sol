// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 1️⃣ Create a Twitter Contract 
// 2️⃣ Create a mapping between user and tweet 
// 3️⃣ Add function to create a tweet and save it in mapping
// 4️⃣ Create a function to get Tweet 
// 5️⃣ Add array of tweets 

contract Twitter {
mapping(address => Tweet[] ) public tweets;

struct Tweet {
	address author;
	uint256 timestamp;
	string content;
	uint256 likes;
}

function createTweet(string memory _tweet) public {
	Tweet memory newTweet = Tweet({
		author: msg.sender,
		timestamp: block.timestamp,
		content: _tweet,
		likes: 0
	});

	tweets[msg.sender].push(newTweet);
}

function getTweet(address _owner, uint _i) public view returns (Tweet memory) {
	return tweets [_owner][_i];
	}

function getAllTweets(address _owner) public view returns (Tweet[] memory){
	return tweets[_owner];
	}
}