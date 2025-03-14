## Learn solidity with these beginner programs in under 30 minutes. 

No software needed to be downloded, all execution are on browser

Use online IDE - https://remix.ethereum.org/
Environment - Remix VM (Cancum)

go to the above IDE and select the Remix VM (Cancum) environment --> create a file called MyContract.sol --> paste one of these programs --> click deploy
and see the results

## 1. Hello World Smart Contract

This is a simple Solidity smart contract that demonstrates the basic structure of a contract with a single function that returns "hello world".

```solidity
pragma solidity 0.8.29;
//1. Hello world
contract MyContract {
    function hello() external pure returns(string memory){
        return "hello world";
    }
} 
```

### Features
- A single external function that returns a greeting message
- Pure function that doesn't read from or modify the blockchain state

### Functions
- `hello()`: Returns the string "hello world"

### Sample Usage
```solidity
// Deploy the contract to a blockchain network
// Then call:
MyContract.hello() // Returns: "hello world"
```

## 2. Simple Storage Contract

A basic smart contract that demonstrates how to store and retrieve data on the blockchain.

```solidity
//2. Hello World Contract with simple storage variable
contract MyContract {
    uint public data;
    function set(uint _data) external {
        data = _data;
    }
    function get() external view returns(uint){
        return data;
    }
}
```

### Features
- Public state variable for data storage
- Functions to set and get the stored value

### Functions
- `set(uint _data)`: Stores the provided value in the contract's state
- `get()`: Returns the currently stored value
- `data`: Public variable that can be accessed directly

### Sample Usage
```solidity
// After deployment:
MyContract.set(42)
MyContract.get() // Returns: 42
MyContract.data() // Returns: 42
```

## 3. Counter Contract

A simple counter contract that allows incrementing and decrementing a value stored on the blockchain.

```solidity
//3. Counter
contract MyContract {
    uint public count;
    
    function increment() external {
        count+=1;
    }
    function decrement() external {
        require(count >0, "count is already at 0");
        count-=1;
    }
    function getCount() external view returns(uint){
    return count;
    }
}
```

### Features
- Public counter variable
- Functions to increment and decrement the counter
- Safety check to prevent decrementing below zero

### Functions
- `increment()`: Increases the counter by 1
- `decrement()`: Decreases the counter by 1 (if greater than 0)
- `getCount()`: Returns the current counter value
- `count`: Public variable that can be accessed directly

### Sample Usage
```solidity
// After deployment:
MyContract.increment() // count = 1
MyContract.increment() // count = 2
MyContract.getCount() // Returns: 2
MyContract.decrement() // count = 1
MyContract.count() // Returns: 1
```

## 4. Timelock Contract

A contract that locks funds for a specified period before allowing withdrawal by the owner.

```solidity
//4. Timelock
contract MyContract {
    uint public unclockTime;
    address public owner;
    
    constructor(uint _unlockOffset) payable {
    unclockTime = block.timestamp + _unlockOffset;
    owner = msg.sender;
    }
    function withdraw() external {
        require (block.timestamp >= unclockTime, "Funds are locked");
        require (msg.sender == owner, "you are not authorized");
        (bool sent, ) = payable(owner).call{value: address(this).balance}("");
        require (sent == true, "transfer failed");
    }
}
```

### Features
- Time-based locking mechanism for funds
- Owner-only withdrawal function
- Accepts ETH during deployment

### Functions
- `withdraw()`: Allows the owner to withdraw all funds after the unlock time has passed

### Constructor Parameters
- `_unlockOffset`: Time in seconds to lock the funds (added to the current block timestamp)

### Sample Usage
```solidity
// Deploy with parameters:
// _unlockOffset: 86400 (1 day in seconds)
// value: 1 ether

// After deployment:
// Wait until the unlock time has passed
MyContract.withdraw() // Transfers all contract funds to the owner
```

## 5. Donation Wallet Contract

A wallet contract that automatically makes a 1% donation to a beneficiary whenever funds are received.

```solidity
//5. Wallet + donation. It will hold money, each time u send money, it will make a small donation
contract MyContract {
    address public owner;
    address public beneficiary;
    
    constructor (address _beneficiary){
    owner = msg.sender;
    beneficiary = _beneficiary;
    }
    function updateBeneficiary (address _beneficiary) external payable{
    require(msg.sender == owner, "you are not authorized");
        beneficiary == _beneficiary;
    }
    function deposit() external payable {
    uint donationAmt = msg.value * 1/100;
    (bool sent, ) = payable(beneficiary).call{value: donationAmt}("");
    require(sent == true, "transfer failed");
    }
    
    // 1 ether = 10 power 18 wei
    // 4950000000000000000
    function withdraw(address recipient, uint amount) external payable{
    require(msg.sender == owner, "you are not owner, only owner can withdraw");
    require(address(this).balance >= amount, "you have insufficient balance");
        (bool sent, ) = payable(recipient).call{value: amount}("");
    require(sent == true, "transfer failed");   
    }
    // special function that sends money directly to this contract
    receive() external payable {
    uint donationAmt = msg.value * 1/100;
    (bool sent, ) = payable(beneficiary).call{value: donationAmt}("");
    require(sent == true, "transfer failed");
    } 
}
```

### Features
- Holds ETH with owner-controlled withdrawals
- Automatic 1% donation on deposits
- Configurable beneficiary address

### Functions
- `updateBeneficiary(address _beneficiary)`: Updates the donation recipient (owner only)
- `deposit()`: Deposits ETH to the contract with 1% going to the beneficiary
- `withdraw(address recipient, uint amount)`: Allows the owner to withdraw funds
- `receive()`: Special function that handles direct ETH transfers to the contract

### Constructor Parameters
- `_beneficiary`: The initial address to receive donations

### Sample Usage
```solidity
// Deploy with parameters:
// _beneficiary: 0x123...abc (beneficiary address)

// After deployment:
MyContract.deposit{value: 1 ether}() // Deposits 1 ETH with 0.01 ETH donated to beneficiary
// Or send ETH directly to contract address

// Owner can withdraw:
MyContract.withdraw(0x456...def, 0.5 ether) // Withdraws 0.5 ETH to specified address
```

## 6. Name Registry Contract

A domain name registry that allows users to register names on the blockchain by paying a fee.

```solidity
//6. Name Registry /buying a domain registry on blockchain
//instead of sending payments to long addresses, one can send to following as example
//farawaystar.eth
//app.ens.domains - also provides similar service
contract MyContract {
// define a container of objects
    mapping(string => address) public names;
    address public owner;
    constructor (){
        owner = msg.sender;
    }
    function registerName(string memory _name) external payable {
        require(names[_name] == address(0), "name already taken");
        require(msg.value >= 0.1 ether, "not enough money!");
        (bool sent, ) = payable(owner).call{value: msg.value}("");
        require(sent == true, "transaction failed");
        names[_name] = msg.sender;
    }
    function getAddress(string memory _name) external view returns(address){
        return names[_name];
    }
}
```

### Features
- Maps names to Ethereum addresses
- Requires payment for registration (minimum 0.1 ETH)
- Prevents duplicate name registrations

### Functions
- `registerName(string memory _name)`: Registers a name to the sender's address
- `getAddress(string memory _name)`: Returns the address associated with a name

### Sample Usage
```solidity
// After deployment:
MyContract.registerName{value: 0.1 ether}("myname") // Registers "myname" to sender's address
MyContract.getAddress("myname") // Returns: sender's address (0x123...abc)
```

## 7. Crowdfunding Contract

A contract that implements a simple crowdfunding campaign with a funding goal and deadline.

```solidity
//7. Crowdfunding contract
contract MyContract {
    address public owner;
    uint public goal;
    uint public deadline;
    uint public fundsRaised;
    mapping(address => uint) public contributions;
    constructor(uint _goal, uint _duration){
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _duration;
    }
    function contribute() external payable {
        require (block.timestamp < deadline, "Too late, campaign is closed");
        require (msg.value > 0, "invalid amount");
        contributions[msg.sender] += msg.value;
        fundsRaised += msg.value;
    }
    function withdraw() external {
        require(msg.sender == owner, "you are not authorized to withdraw, only owner can");
        require(block.timestamp >= deadline, "campaign is still running");
        require(fundsRaised >= goal, "Funding goal, not yet reached");
        (bool sent, ) = payable(owner).call{value: address(this).balance}("");
        require(sent == true, "transfer failed");
    }
    function getRefund() external {
        require(block.timestamp >= deadline, "campaign is still running");
        require(fundsRaised < goal, "Funding goal was reached");
        uint amount = contributions[msg.sender];
        require(amount > 0, "no contributions found");
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent == true, "transaction failed");
        contributions[msg.sender] = 0;
    }
}
```

### Features
- Time-limited fundraising campaign
- Funding goal requirement
- Owner withdrawal if goal is met
- Refund mechanism if goal is not met

### Functions
- `contribute()`: Allows users to contribute ETH to the campaign
- `withdraw()`: Allows the owner to withdraw all funds if the goal is met after the deadline
- `getRefund()`: Allows contributors to get refunds if the goal is not met after the deadline

### Constructor Parameters
- `_goal`: The funding goal in wei
- `_duration`: The campaign duration in seconds

### Sample Usage
```solidity
// Deploy with parameters:
// _goal: 10 ether (in wei)
// _duration: 604800 (1 week in seconds)

// After deployment:
MyContract.contribute{value: 2 ether}() // Contributes 2 ETH to the campaign

// After deadline (if goal met):
// Owner can call:
MyContract.withdraw() // Transfers all funds to the owner

// After deadline (if goal not met):
// Contributors can call:
MyContract.getRefund() // Returns their contribution
```

---