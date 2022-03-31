//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "hardhat/console.sol";

contract Payment {
    address public paymentPlatformOwner;
    string public paymentPlatformName;
    struct Friend {
        string name;
        address friendAccount;
    }
    mapping(address => uint256) public customerBalance;
    mapping(address => Friend[]) public customerFriendList;

    constructor() {
        paymentPlatformOwner = msg.sender;
    }

    // Owner Functions

    // function setPlatformName(string memory _name) external {
    //     require(
    //         msg.sender == paymentPlatformOwner,
    //         "You must be the owner to set the name of the payment platform"
    //     );
    //     paymentPlatformName = _name;
    // }

    // function getBankBalance() public view returns (uint256) {
    //     require(
    //         msg.sender == paymentPlatformOwner,
    //         "You must be the owner of the bank to see all balances."
    //     );
    //     return address(this).balance;
    // }

    // Customer Functions
    function addFriend(string memory _name, address _account) public {
        customerFriendList[msg.sender].push(Friend(_name, _account));
    }

    function getCustomerBalance() external view returns (uint256) {
        return customerBalance[msg.sender];
    }

    function depositMoney() public payable {
        require(msg.value != 0, "You need to deposit some amount of money!");
        customerBalance[msg.sender] += msg.value;
    }

    function withDrawMoney(address payable _to, uint256 _total) public payable {
        require(
            _total <= customerBalance[msg.sender],
            "You have insuffient funds to withdraw"
        );

        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    function transferMoney(address payable _to, uint256 _total) public payable {
        require(
            _total <= customerBalance[msg.sender],
            "You have insuffient funds to transfer"
        );

        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }
}
