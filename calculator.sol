// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Calculator{

    function add(int num1, int num2) external pure returns (int) {
        return num1+num2;
    }

    function subtract(int num1, int num2) external pure returns (int) {
        return num1-num2;
    }

    function divide(int num1, int num2) external pure returns (int) {
        return num1/num2;
    }

    function multiply(int num1, int num2) external pure returns (int) {
        return num1*num2;
    }

    function modulus(int num1, int num2) external pure returns (int) {
        return num1%num2;
    }
}

/*
1. External functions cannot be called from within the same contract. (Saves gas)
2. All function parameters are local variables and since its an external function, the parameters are stored in calldata.
3. 'pure' is a type of state mutability. Functions declared with pure can neither read nor modify the state.
*/
