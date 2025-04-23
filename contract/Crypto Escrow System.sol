// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoEscrow {
    address public payer;
    address public payee;
    address public arbiter;
    uint256 public amount;
    bool public isFunded;

    constructor(address _payee, address _arbiter) payable {
        payer = msg.sender;
        payee = _payee;
        arbiter = _arbiter;
        amount = msg.value;
        isFunded = true;
    }

    function releaseFunds() external {
        require(msg.sender == arbiter, "Only arbiter can release funds");
        require(isFunded, "No funds available");
        isFunded = false;
        payable(payee).transfer(amount);
    }

    function refundPayer() external {
        require(msg.sender == arbiter, "Only arbiter can refund");
        require(isFunded, "No funds available");
        isFunded = false;
        payable(payer).transfer(amount);
    }
}

