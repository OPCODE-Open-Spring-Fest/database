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
    mapping (string => bool) public added;
    uint256 public count=0;
    constructor()
    {

    }
    modifier Added (string memory aadhar) 
    {
        require(!added[aadhar],"Details already added");
        _;
    }
    
    function addPerson(string calldata aadharId,string calldata name, string calldata DOB, string calldata phoneNo ) public Added (aadharId)
    {
        Details memory person = Details({aadharId: aadharId,name: name,DOB: DOB,phoneNo: phoneNo});
        list[count]=person;
        added[aadharId]=true;
        count++;
    }

    





}
