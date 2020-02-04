pragma solidity ^0.5.0;

/// @title A basic smart contract
/// @author Nazzareno Massari
/// @notice You can use this contract to test basics of a coffeeshop
/// @dev All function calls are tested without side effects

contract Coffeeshop {

/// Bob is the Owner of the coffeeshop
address payable bob;


/// Coffees available in the coffeeshop
struct Coffee {

	bytes32 description;
	uint price;
}
	
/// Static array of coffees
Coffee[3] public coffees;


/// @notice Add a Coffee 
/// @dev Used to add coffees when the contract is deployed, set as internal
/// @param _coffeeId The coffee Id
/// @param _description The type of coffee
/// @param _price The price of the coffee 
function addCoffee(uint _coffeeId, bytes32 _description, uint _price) internal {
    coffees[_coffeeId].description =_description;
    coffees[_coffeeId].price = _price;
}


/** Constructor of the Coffeeshop smart contract
  * which sets the owner address 
  * and initialise the coffee list, expressing the price in ether (0.020 ether ~ 2.65 pounds, 0.025 ether ~ 3.10 pounds)
  */
constructor() public {

	bob = msg.sender;
	addCoffee(0, 'Americano', 0.020 ether);
	addCoffee(1, 'Latte', 0.025 ether);
	addCoffee(2, 'Cappuccino', 0.025 ether);
}

/// Fallback function
function() external payable {
	revert();
}

/// Check if coffeId is valid, between 0 and 2
modifier validId(uint _coffeeId) {
	require(_coffeeId >= 0 && _coffeeId <= 2, 'Coffee ID out of range!');
	_;
}

/// Check if the value paid is enough
modifier paidEnough(uint _coffeeId) {
    uint price = coffees[_coffeeId].price;
    require(msg.value >= price, 'Insufficient amount of funds!');
    _;
}

/** Tranfer the change to the buyer (Alice) using address.call.value()() instead of address.transfer() as 
  * there are implications in the the Istanbul hard fork (EIP-1884). 
  */
modifier checkValue(uint _coffeeId) {
    _;
    uint price = coffees[_coffeeId].price;
    uint amountToRefund = msg.value - price;
    require(amountToRefund > 0);
    (bool success, ) = msg.sender.call.value(amountToRefund)("");
    require(success, "Transfer failed.");
}

/// @notice Transfer the correct amount to seller (Bob) after checking if the coffeeId is valid, the buyer (Alice) has paid enough, and after send the change to buyer
/// @dev used modifiers and Checks-Effects-Interactions pattern to avoid Reentrancy Attacks.
/// @param _coffeeId The Coffee Id
function buy(uint _coffeeId) public payable validId(_coffeeId) paidEnough(_coffeeId) checkValue(_coffeeId) {	
	(bool success, ) = bob.call.value(coffees[_coffeeId].price)("");
	require(success, "Transfer failed.");
}

}
