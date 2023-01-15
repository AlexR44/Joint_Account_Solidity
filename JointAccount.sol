pragma solidity ^0.5.0;

contract JointSavings {
    //initializing variables

    address payable OwnerOne; // account 1
    address payable OwnerTwo; // account 2
    address public lastToWithdraw; // placeholder for last to withdraw owner
    uint public lastWithdrawAmount; // placeholder for last to withdraw amount
    uint public contractBalance; //balance
    string customerOneName;
    string customerTwoName;

    //defining function `setAccounts` that receives two payable addresses 
    function setAccounts(address payable account1, address payable account2,string memory newCustomerName1, string memory newCustomerName2) public{
        OwnerOne=account1;
        OwnerTwo=account2;
        customerOneName = newCustomerName1;
        customerTwoName = newCustomerName2;
    }

   // defining withdraw function for contract
    function withdraw(uint amount, address payable recipient) public {
        require(recipient == OwnerOne || recipient == OwnerTwo, "You don’t own this account!"); //checking if recipients are owners
        require(contractBalance>=amount, "Insufficient funds!"); //checking if there are enough funds
        //updating last to withdraw record
        if (lastToWithdraw != recipient) {
            lastToWithdraw=  recipient;
        }
        recipient.transfer(amount);
        lastWithdrawAmount=amount; // updating last withdraw amount to withdrawal amount
        contractBalance = address(this).balance;// updating contract balance
    }

    // Defining a deposit function for the contract
    function deposit() public payable {
        contractBalance = address(this).balance;//return the updated contract balance
    }
    // defining fallback deposit function 
    function() external payable {}
  
}