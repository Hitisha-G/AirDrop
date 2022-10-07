 pragma solidity ^0.4.17;
 
 //Contract creation file
 
 contract Airdrop{
     
     address public owner;
     address[] public members;
     
     constructor() public{
         owner = msg.sender;
     }
     
     function enter() public payable{
         
         require(msg.value > 0.1 ether);
         members.push(msg.sender);
     }
     
     function random() private view returns(uint){
         return uint(keccak256(abi.encodePacked(block.difficulty, now, members)));
     }
     
     function pickWinner() public OnlyOwner{
         
         uint index = random() % members.length;
         members[index].transfer(this.balance);
         members = new address[](0);
     }
     
     modifier OnlyOwner(){
         require(msg.sender == owner);
         _;
     }
     
     function getMember() public view returns(address[]){
         return members;
     } 
     
 }
