// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0<0.9.0;

contract Database{

    struct Details {
        string aadharId;
        string name;
        string DOB;
        string phoneNo;
        string rollNo;
        string batchNo;

    }
    
    mapping( address => Details) public list;

    uint256 public count=0;
    constructor()
    {

    }

    modifier personPresent{
        require(keccak256(abi.encodePacked(list[msg.sender].aadharId)) != keccak256(abi.encodePacked("")), "Person doesn't exist");
        _;
    }

    function addPerson(string memory aadharId,string memory name, string memory DOB, string memory phoneNo, string memory rollNo, string memory batchNo) public 
    {
        Details memory person = Details({aadharId: aadharId,name: name,DOB: DOB,phoneNo: phoneNo, rollNo: rollNo, batchNo: batchNo});
        list[msg.sender]=person;
        count++;
    }
    
    function updateDetails(string memory aadharId,string memory name, string memory DOB, string memory phoneNo, string memory rollNo, string memory batchNo)public personPresent{
        Details storage person = list[msg.sender];
        person.aadharId = aadharId;
        person.name = name;
        person.DOB = DOB;
        person.phoneNo = phoneNo;
        person.rollNo = rollNo;
        person.batchNo = batchNo;
    }




}
