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
    mapping( string => bool) public added;
    mapping( string => Details) private aadharToUser;
 
    uint256 public count=0;
    address public admin;
    bool alreadyset=false;

    constructor()
    {

    }

    modifier Added (string memory aadhar) 
    {
        require(!added[aadhar],"Details already added");
        _;
    }

    modifier personPresent{
        require(keccak256(abi.encodePacked(list[msg.sender].aadharId)) != keccak256(abi.encodePacked("")), "User doesn't exist");
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

    function set_Admin( address _admin) public onlyOnce()
    {
        admin=_admin;
        alreadyset=true;
    }

    function changeAdmin(address newadmin) public onlyAdmin()
    {
        admin=newadmin;
    }

    function getAdress()external view returns(address){
        return msg.sender;
    }
    
    function addPerson(string memory aadharId,string memory name, string memory DOB, string memory phoneNo, string memory rollNo, string memory batchNo) public 
    {
        require(bytes(list[msg.sender].aadharId).length == 0, "User already exists");
        Details memory person = Details({aadharId: aadharId,name: name,DOB: DOB,phoneNo: phoneNo, rollNo: rollNo, batchNo: batchNo});
        list[msg.sender]=person;
        added[aadharId] = true;
        aadharToUser[aadharId] = person;
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
    function checkDetails()public personPresent view returns(string[6] memory){
        Details memory person = list[msg.sender];
        string[6] memory details = [person.aadharId, person.name, person.DOB, person.phoneNo, person.rollNo, person.batchNo];
        return details;
    }

    function findByAadhaarId(string memory _aadharId)public view onlyAdmin returns(string[6] memory){
        require((bytes(aadharToUser[_aadharId].aadharId).length > 0), "Not found");
        Details memory person = aadharToUser[_aadharId];
        string[6] memory details = [person.aadharId, person.name, person.DOB, person.phoneNo, person.rollNo, person.batchNo];
        return details;
    }
    
}

