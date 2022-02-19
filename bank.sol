// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Bank{
    //Default visibility for state variables is 'internal'
    uint totalContractBalance = 0;

    mapping(address => uint) balances;
    mapping(address => uint) depositTimestamps;


    //Payable function as the function caller(msg.sender) sends ether to this function call
    function addBalance() public payable{
        balances[msg.sender] = msg.value; //in wei
        depositTimestamps[msg.sender] = block.timestamp;
        totalContractBalance += msg.value;
    }


    //returns balance along with interest
    //view: Functions declared with view can only read the state, but do not modify it.
    function getBalance(address userAddress) public view returns (uint){
        //seconds
        uint timeElapsed = block.timestamp - depositTimestamps[userAddress];

        uint principal = balances[userAddress];

        //simple interest at the rate of 7% pa
        return principal + uint((principal*7*timeElapsed)/(100*365*24*60*60)) + 1; 
        
    }

    //withdraw your entire deposit along with interest
    function withdrawTotal() public payable{
        uint amountToTransfer = getBalance(msg.sender);     

        /*making the address payable ensures that the corresponding address is viable to send ether to */
        address payable withdrawTo = payable(msg.sender);
        withdrawTo.transfer(amountToTransfer);
        totalContractBalance -= amountToTransfer;
        balances[msg.sender] = 0;
    }


    //amount is in wei
    function withdrawSpecific(uint amount) public payable{
        uint currentBalance = getBalance(msg.sender);
        require(amount <= currentBalance, "Insufficient balance");

        address payable withdrawTo = payable(msg.sender);
        withdrawTo.transfer(amount);
        totalContractBalance -= amount;
        balances[msg.sender] -= amount;
    }

    function addMoneyToContract() public payable{
        totalContractBalance += msg.value;
    }


}
