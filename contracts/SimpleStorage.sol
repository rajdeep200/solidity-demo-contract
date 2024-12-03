// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SimpleStorage {
    enum KycStatus {Pending, InProgress, Active, Rejected, Deleted }
    KycStatus public kycStatus;
    struct User {
        uint256 id;
        string firstName;
        string lastName;
        string email;
        KycStatus kycStatus;
    }

    User[] public userList;

    constructor() {
        kycStatus = KycStatus.Pending;
    }

    function makeInProgress(uint id) public {
        for(uint i=0; i<userList.length; i++){
            if(id == userList[i].id){
                userList[i].kycStatus = KycStatus.InProgress;
                break;
            }
        }
    }

    function activate(uint256 id) public{
        for(uint i=0; i<userList.length; i++){
            if(id == userList[i].id){
                userList[i].kycStatus = KycStatus.Active;
                break;
            }
        }
    }

    function reject() public {
        kycStatus = KycStatus.Rejected;
    }

    function addUser(uint256 id, string memory firstName, string memory lastName, string memory email) public {
        userList.push(User(id, firstName, lastName, email, KycStatus.Pending));
    }

    function deleteUser(uint256 id) public {
        uint index = findUserIndex(id);
        require(index<userList.length, "USer not found");

        userList[index] = userList[userList.length - 1];
        userList.pop();
    }

    function getUserInfoById(uint id) public view returns(User memory) {
        for(uint i=0; i<userList.length; i++){
            if(userList[i].id == id){
                return userList[i];
            }
        }

        revert("User Not Found");
    }

    function findUserIndex(uint id) private view returns (uint)  {
        for (uint i=0; i<userList.length; i++) 
        {
            if(id == userList[i].id){
                return i;
            }
        }
        revert("User not found");
    }
}