// SPDX-License-Identifier: MIT

// 1️⃣ Create a loop to calcualte all expenses for the user
// HINT: Create a total expenses variable with uint type
// HINT: Loop over expenses array with for loop
// HINT: add up all expenses cost
// HINT: return total expenses

pragma solidity ^0.8.0;

contract ExpenseTracker{


// mapping(address => Expense[]) public Expenses;

Expense[] public Expenses;

struct Expense {
    address user;
    string description;
    uint amount;
}


constructor() {
    Expenses.push(Expense(msg.sender, "something 1", 10));
    Expenses.push(Expense(msg.sender, "something 2", 5));
    Expenses.push(Expense(msg.sender, "something 3", 7));
}


function addExpense(string memory _description, uint _amount) public{
	Expenses.push(Expense(msg.sender, _description, _amount));
	}

function getTotalExpenses(address _user) public view returns (uint) {
	uint totalExpenses;
	for (uint i = 0; i < Expenses.length; i++) {
		if (Expenses[i].user == _user){
			totalExpenses += Expenses[i].amount;
		}	
	}
	return totalExpenses;
	}

}


