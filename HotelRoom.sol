pragma solidity ^0.6.0;

contract HotelRoom {

    address payable public owner;
    
    enum Statuses {
        vacant, occupied
    }

    event occupied(address _occupant,uint _value);

    modifier onlyWhileVacent {
        require( currentStatus == Statuses.vacant, "currently occupied");
        _;
    }

    Statuses currentStatus;

    constructor() public{
        owner = msg.sender;
        currentStatus = Statuses.vacant;  
    }

    modifier cost(uint _amount) {
        require(msg.value == _amount, "Not enough Ethets");
        _;
    }

    function book() external payable onlyWhileVacent cost(2 ether) {
        currentStatus = Statuses.occupied;
        owner.transfer(msg.value);
        emit occupied(msg.sender,msg.value);
    }

    function checkout() public {
        currentStatus = Statuses.vacant;
    }
}
