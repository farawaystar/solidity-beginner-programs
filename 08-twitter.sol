// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 1️⃣ Create a Twitter Contract 
// 2️⃣ Create a mapping between user and tweet 
// 3️⃣ Add function to create a tweet and save it in mapping
// 4️⃣ Create a function to get Tweet 
// 5️⃣ Add array of tweets
// -------------------15-------------------
// 1️⃣ Define a Tweet Struct with author, content, timestamp, likes
// 2️⃣ Add the struct to array
// 3️⃣ Test Tweets
// -------------------15-------------------
// 1️⃣  Use require to limit the length of the tweet to be only 280 characters
// HINT: use bytes to length of tweet
// -------------------17-------------------
// 1️⃣ Add a function called changeTweetLength to change max tweet length
// HINT: use newTweetLength as input for function
// 2️⃣ Create a constructor function to set an owner of contract
// 3️⃣ Create a modifier called onlyOwner
// 4️⃣ Use onlyOwner on the changeTweetLength function
// -------------------18-------------------
// 1️⃣ Add id to Tweet Struct to make every Tweet Unique
// 2️⃣ Set the id to be the Tweet[] length 
// HINT: you do it in the createTweet function
// 3️⃣ Add a function to like the tweet
// HINT: there should be 2 parameters, id and author
// 4️⃣ Add a function to unlike the tweet
// HINT: make sure you can unlike only if likes count is greater then 0
// 4️⃣ Mark both functions external
// --------------------21------------------
// 1️⃣ Create Event for creating the tweet, called TweetCreated ✅
// USE parameters like id, author, content, timestamp
// 2️⃣ Emit the Event in the createTweet() function below  ✅
// 3️⃣ Create Events for liking & Unliking the tweet, called TweetLiked and TweetUnLiked ✅ 
// USE parameters like liker/unLiker, tweetAuthor, tweetId, newLikeCount
// 4️⃣ Emit the event in the likeTweet() & unLikeTweet functions respectively  ✅

contract Twitter {
address public owner;
mapping(address => Tweet[] ) public tweets;
uint16 public MAX_TWEET_LENGTH = 280;

struct Tweet {
    uint256 id;
	address author;
    string content;
	uint256 timestamp;
	uint256 likes;
}

constructor(){
    owner = msg.sender;
}

modifier onlyOwner {
    require(msg.sender == owner, "You are not authorized");
    _;
}

event TweetCreated (uint256 id, address author, string content, uint256 timestamp);
event TweetLiked (address liker, address tweetAuthor, uint256 tweetid, uint256 newLikeCount);
event TweetUnLiked (address unLiker, address tweetAuthor, uint256 tweetid, uint256 newLikeCount);

function createTweet(string memory _tweet) public {
    require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "tweet length exceeded");
	Tweet memory newTweet = Tweet({
		author: msg.sender,
		timestamp: block.timestamp,
		content: _tweet,
		likes: 0,
        id: tweets[msg.sender].length // use the length of the tweet to)
	});

	tweets[msg.sender].push(newTweet);
    emit TweetCreated (newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp); 
}

function getTweet(uint _i) public view returns (Tweet memory) {
	return tweets [msg.sender][_i];
	}

function getAllTweets(address _owner) public view returns (Tweet[] memory){
	return tweets[_owner];
	}

function changeTweetLength(uint16 newMaxTweetLength) public onlyOwner{
    MAX_TWEET_LENGTH = newMaxTweetLength;
    }

function likeTweet(address author, uint256 id) external{
    require(tweets[author][id].id == id, "Tweet doesnt exist");
    tweets[author][id].likes++;

    emit TweetLiked (msg.sender, author, id, tweets[author][id].likes);

    }

function unlikeTweet(address author, uint256 id) external{
    require(tweets[author][id].id == id, "Tweet doesnt exist");
    require(tweets[author][id].likes > 0, "Tweet has no likes");
    tweets[author][id].likes--;

    emit TweetUnLiked (msg.sender, author, id, tweets[author][id].likes);
    }
}