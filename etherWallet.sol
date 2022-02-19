// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract EtherWallet{
    address payable public owner;

    //We use the constructor to capture the wallet owners' address
    constructor(){
        owner = payable(msg.sender);
    }

    /*
    receive() is executed on a call to the contract that sends Ether and does 
    not specify any function (empty call data). 
    This is the function that is executed on plain Ether transfers 
    (e.g. via .send() or .transfer()). 
    */
    receive() external payable {}


    //Returns the current balance in wei
    function getWalletBalance() public view returns (uint){
        return address(this).balance;
    }


    function withdraw(uint _amount) external {
        //Transaction fails if the call is made by an address that is not the owner
        require(owner == msg.sender, "Only the owner can withdraw funds");

        uint currentBalance = getWalletBalance();

        //Transaction fails if amount to withdraw is greater than the wallet balance
        require(_amount <= currentBalance, "Insufficient balance!!");

        payable(msg.sender).transfer(_amount);
    }
}

/*
NOTE: To send ether to this contract via remix, enter the amount under the 'value' field
and hit 'Transact'(Found at the bottom of the left side pane) with an empty CallData body.


About receive() function: [https://betterprogramming.pub/learn-solidity-functions-ddd8ea24c00d]
    - A contract can have at most one receive function. 
    - This function cannot have arguments, cannot return anything, and must have external visibility and payable state mutability.
    - It is executed on a call to the contract that sends Ether and does not specify any function (empty call data). 
    - This is the function that is executed on plain Ether transfers (e.g. via .send() or .transfer()).
*/
