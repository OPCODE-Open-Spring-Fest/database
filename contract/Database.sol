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
    
    function addPerson(string calldata aadharId,string calldata name, string calldata DOB, string calldata phoneNo ) public Added (aadharId)
    {
        Details memory person = Details({aadharId: aadharId,name: name,DOB: DOB,phoneNo: phoneNo});
        list[count]=person;
        added[aadharId]=true;
        count++;
    }

    





}
