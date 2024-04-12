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


    mapping( string => Details) private aadharToUser;
    mapping( address => Details) private list;
    uint256 private count=0;
    mapping( string => bool ) public added;
    mapping( address => bool ) public restrictedUser;
    mapping( string => address ) public aadharToAddress;
    address public admin;
    bool alreadyset=false;

    constructor()
    {

    }


    modifier personPresent{
        require(keccak256(abi.encodePacked(list[msg.sender].aadharId)) != keccak256(abi.encodePacked("")), "User doesn't exist");
        _;
    } 
    modifier Added (string memory aadhar) 
    {
        require(!added[aadhar],"Details already added");
        _;
    }

    modifier onlyOnce()
    {
        require(!alreadyset,"Admin is already set");
        _;
    }

    modifier onlyAdmin()
    {
        require(msg.sender==admin,"Only admin can call this function");
        _;
    }

    modifier isNotRestricted(){
        require(!restrictedUser[msg.sender], "User is restricted");
        _;
    }

    function set_Admin( address _admin) public onlyOnce()
    {
        admin=_admin;
        alreadyset=true;
    }

    function changeAdmin(address newadmin) public onlyAdmin()
    {
        admin=newadmin;
    }

    function getAddress()external view returns(address){
        return msg.sender;
    }

    function addPerson(string memory aadharId,string memory name, string memory DOB, string memory phoneNo, string memory rollNo, string memory batchNo) public Added (aadharId) isNotRestricted
    {
        require(bytes(list[msg.sender].aadharId).length == 0, "User already exists");
        Details memory person = Details({aadharId: aadharId,name: name,DOB: DOB,phoneNo: phoneNo, rollNo: rollNo, batchNo: batchNo});
        list[msg.sender]=person;
        added[aadharId] = true;
        aadharToAddress[aadharId] = msg.sender;
        aadharToUser[aadharId] = person;
        count++;
    }

    function updateDetails(string memory aadharId,string memory name, string memory DOB, string memory phoneNo, string memory rollNo, string memory batchNo)public personPresent isNotRestricted {
        Details storage person = list[msg.sender];
        person.aadharId = aadharId;
        person.name = name;
        person.DOB = DOB;
        person.phoneNo = phoneNo;
        person.rollNo = rollNo;
        person.batchNo = batchNo;
        added[aadharId]=true;

    }
    function checkDetails()public personPresent view personPresent returns(string[6] memory){
        Details memory person = list[msg.sender];
        string[6] memory details = [person.aadharId, person.name, person.DOB, person.phoneNo, person.rollNo, person.batchNo];
        return details;
    }

    function findByAadhaarId(string memory _aadharId)public view onlyAdmin returns(string[6] memory){
        require((bytes(aadharToUser[_aadharId].aadharId).length > 0), "User not found");
        Details memory person = aadharToUser[_aadharId];
        string[6] memory details = [person.aadharId, person.name, person.DOB, person.phoneNo, person.rollNo, person.batchNo];
        return details;
    }
    
    function deleteUser(string memory _aadharId)public onlyAdmin {
        require((bytes(aadharToUser[_aadharId].aadharId).length > 0), "User not found");
        Details memory person = aadharToUser[_aadharId];
        person.aadharId = "";
        list[aadharToAddress[_aadharId]] = person;
        aadharToUser[_aadharId] = person;
        
        added[_aadharId] = false;
        count--;
        restrictedUser[aadharToAddress[_aadharId]] = true;        
    }

    function restrictUser(string memory _aadharId)public onlyAdmin {
        restrictedUser[aadharToAddress[_aadharId]] = true;
    }

}
