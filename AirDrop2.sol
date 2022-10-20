//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract Airdrop
{
    address payable owner;
    uint public winner_id;

    constructor()
    {
        owner=payable(msg.sender);
    }

    struct Members{
        uint uid;
        string name;
        uint age;
        address payable member_add;
        bool registered;
    }

    mapping(uint => Members) mem;
    uint public numMem;

    mapping(address=> bool) registered_member;

    function register_members(uint _uid,string memory _name,uint _age) public returns(uint ,string memory, uint)
    {
        require(registered_member[msg.sender]!=true,"already registered");
        Members storage newMem= mem[numMem];
        numMem++;
        newMem.member_add=payable(msg.sender);
        newMem.uid=_uid;
        newMem.name=_name;
        newMem.age=_age;
        newMem.registered=true;
        registered_member[msg.sender] = true;
        return(newMem.uid,newMem.name,newMem.age);
        
    }

    modifier onlyOwner(){
        require((msg.sender)==owner);
        _;
    }

    function random(uint mod ) public returns(uint)
     {
        require(msg.sender==owner,"only owner can run this function");
         winner_id =  uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender))) % mod;
        return(winner_id);
     }
     address payable winner;

     function Winner() public  returns(address)
     {
         require(msg.sender==owner,"only owner can run this function");


        winner = mem[winner_id].member_add;
        return(winner);
     }

    // winner.transfer(1);
    winner.transfer(1 ether);
}
