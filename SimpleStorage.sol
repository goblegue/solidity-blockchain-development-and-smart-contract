//SPDX-License-Identifier:MIT
pragma solidity 0.8.18;

contract SimpleStorage{
    uint256 favoritNumber ;//default value is zero

    struct Person{
        uint256 favoritNumber;
        string name;
    }

    Person[] public personList;

    mapping(string => uint256) public nameToFavouritNum;

    function store(uint _favoriteNumber) public virtual {
        favoritNumber=_favoriteNumber;
    }
    function retrive() public view returns (uint256){
        
        return favoritNumber;
    }
    function addPerson (string memory _name,uint256 _favoritNumber)public {
        personList.push(Person({name:_name,favoritNumber:_favoritNumber}));
        nameToFavouritNum[_name]=_favoritNumber;
    }
}

