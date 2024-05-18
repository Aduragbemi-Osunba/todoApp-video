// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ToDoList {  //contract name
    uint256 public _idUser;     //every user will be assigned an id
    address public ownerOfContract; //the one who will deploy the contract

    address[] public creators; //address of users
    string[] public message;
    uint256[] public messageId;

    struct ToDoListApp{
        address account;
        uint256 userId;
        string message;
        bool completed;
    }

    event ToDoEvent(
        address indexed account,
        uint256 indexed userId,
        string message,
        bool completed
    );

    mapping(address => ToDoListApp) public toDoListApps;
//ToDoListApps contains information about the users,properties.
//ToDoListApp contains info about the individuals
//we use mapping so we can identify the information of the user base on their address


    constructor() {
        ownerOfContract = msg.sender;
    }
    function inc() internal {
        _idUser++;
    
//to implement userId, it will increment the userid anytime its being called
}


function createList(string calldata _message) external {
    inc ();

    uint256 idNumber = _idUser;
    ToDoListApp storage toDo = toDoListApps[msg.sender];

    toDo.account = msg.sender;
    toDo.message = _message;
    toDo.completed = false;
    toDo.userId = idNumber;

    creators.push(msg.sender);
    message.push(_message);
    messageId.push(idNumber);

    emit ToDoEvent(msg.sender,toDo.userId, _message, toDo.completed);
}

function getCreatorData(address _address) public view returns (address, uint256, string memory, bool){
    ToDoListApp memory singleUserData = toDoListApps[_address];

    return (
        singleUserData.account,
        singleUserData.userId,
        singleUserData.message,
        singleUserData.completed
    );
}

function getAddress() external view returns (address[] memory) {
    return creators;
}
function getMessage () external view returns (string[] memory) {
    return message;

}
function toggle(address _creator) public { 
    ToDoListApp storage singleUserData = toDoListApps[_creator];
    singleUserData.completed = !singleUserData.completed;
}
}