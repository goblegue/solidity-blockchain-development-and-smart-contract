//SPDX-Lincense-Identifier:MIT

pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public listOfSimpleStorage;
    
    function createSimpleStorageContract() public {
        listOfSimpleStorage.push( new SimpleStorage());
    }

    function sfStore(uint _simpleStorageIndex, uint _newSimpleStorageNum) public {
        require(_simpleStorageIndex < listOfSimpleStorage.length, "Invalid index");
        
        // set the value of the variable in the contract at the given address to the given value 
        listOfSimpleStorage[_simpleStorageIndex].store(_newSimpleStorageNum);
    }

    function sfGet(uint _simpleStorageIndex) public view returns (uint256){
        require(_simpleStorageIndex < listOfSimpleStorage.length, "Invalid index");
        listOfSimpleStorage[_simpleStorageIndex].retrive();
    }

}