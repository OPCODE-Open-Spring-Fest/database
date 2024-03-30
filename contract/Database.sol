// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0<0.9.0;

contract Database{

    struct Details {
        string aadharId;
        string name;
        string DOB;
        string phoneNo;
        uint rollNo;
        uint batchNo;

    }
    
    mapping( address => Details) public list;

    uint256 public count=0;
    constructor()
    {

    }

    modifier personPresent{
        require(list[msg.sender].rollNo!=0, "User doesn't exist");
        _;
    }

    function addPerson(string calldata aadharId,string calldata name, string calldata DOB, string calldata phoneNo, uint rollNo, uint batchNo) public 
    {
        Details storage person = Details({aadharId: aadharId,name: name,DOB: DOB,phoneNo: phoneNo, rollNo: rollNo, batchNo: batchNo});
        list[msg.sender]=person;
        count++;
    }
    
    function updateDetails(string calldata aadharId,string calldata name, string calldata DOB, string calldata phoneNo, uint rollNo, uint batchNo)public personPresent{
        Details storage person = list[msg.sender];
        person.aadharId = aadharId;
        person.name = name;
        person.DOB = DOB;
        person.phoneNo = phoneNo;
        person.rollNo = rollNo;
        person.batchNo = batchNo;
    }




}
