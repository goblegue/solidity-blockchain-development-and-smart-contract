//Get Funds from Users
//Withdraw funds
//Set a minimum value in USD

//SPDX=License-Identifier:MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();
error CallFailed();

contract FundMe{

    using PriceConverter for uint256;

    address public immutable i_owner;
    uint public constant MINIMUM_USD = 5e18;
    address[] public funders;
    mapping(address => uint256) public addressToFundedAmount;

    constructor(){
        i_owner=msg.sender;
    }

    function fund() public payable {
        
        require(msg.value.getConversionRate()>=MINIMUM_USD,"didn't send enough ETH");
        funders.push(msg.sender);
        addressToFundedAmount[msg.sender] += msg.value;
    }
    function withdraw() public onlyOwner {
        for(uint funderIndex = 0; funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToFundedAmount[funder] = 0;
        }
        // funders= new address[](0);
        // //transfer
        // payable(msg.sender).transfer(address(this).balance);
        // //send 
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"send failed");
        //call
        (bool callSuccess,)=payable(msg.sender).call{value: address(this).balance}("");
        // require(callSuccess,"Call failed");
        if (!callSuccess){revert CallFailed();}
    }
    modifier onlyOwner(){
        // require(msg.sender==i_owner,"sender must be the owner");
        if(msg.sender!= i_owner){revert NotOwner();}
        _;
    }

    receive() external payable {
        fund();
     }

     fallback() external payable { 
        fund();
     }

   
}