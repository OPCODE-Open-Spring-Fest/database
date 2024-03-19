// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0<0.9.0;

contract Database{
    struct Details {
        string aadharId;
        string name;
        string DOB;
        string phoneNo;

    }
    
    mapping( uint256=> Details) public list;

    uint256 public count=0;
    constructor()
    {

    }

    function addPerson(string calldata aadharId,string calldata name, string calldata DOB, string calldata phoneNo) public 
    {
        Details memory person = Details({aadharId: aadharId,name: name,DOB: DOB,phoneNo: phoneNo});
        list[count]=person;
        count++;
    }
    





}
