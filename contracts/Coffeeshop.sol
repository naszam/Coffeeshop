pragma solidity ^0.5.0;


contract Coffeeshop {

// owner of the coffeeshop
address payable bob;


// Coffees available in the coffeeshop
struct Coffee {

	bytes32 description;
	uint price;
	address payable buyer;
}
	
// static array of coffees
Coffee[3] public coffees;


// function to add coffee 
function addCoffee(uint _coffeeId, bytes32 _description, uint _price) public {
    Coffee memory newCoffee;
    
    newCoffee.description =_description;
    newCoffee.price = _price;
    coffees[_coffeeId] = newCoffee;
}


/* Constructor of Coffeeshop contract
 * which sets the owner address
 * and initialise the coffee list, expressing the price in ether (0.020 ether ~ 2.65 pounds, 0.025 ether ~ 3.10 pounds)
 */
constructor() public {

	bob = msg.sender;
	addCoffee(0, 'Americano', 0.020 ether);
	addCoffee(1, 'Latte', 0.025 ether);
	addCoffee(2, 'Cappuccino', 0.025 ether);
}

// Fallback function
function() external payable {}

// Check if coffeId is valid, between 0 and 3
modifier validId(uint _coffeeId) {
	require(_coffeeId >= 0 && _coffeeId <3);
	_;
}

// Check if the value paid is enough
modifier paidEnough(uint _price) {
    
    require(msg.value >= _price);
    _;
}

/* Tranfer the change to buyer (Alice) using address.call.value()() instead of address.transfer() as 
 * there are implications in the the upcoming Istanbul Ethereum upgrade scheduled for the first week of December
 */
modifier checkValue(uint _coffeeId) {
    _;
    uint _price = coffees[_coffeeId].price;
    uint amountToRefund = msg.value - _price;
    (bool success, ) = coffees[_coffeeId].buyer.call.value(amountToRefund)("");
    require(success);
}

// Set the buyer (Alice) address and transfer the correct amount to seller (Bob) after checking if the coffeeId is valid, the buyer has paid enough, and after send the change to buyer
function buy(uint _coffeeId, uint _price) public payable validId(_coffeeId) paidEnough(_price) checkValue(_coffeeId) returns(uint) {	
	coffees[_coffeeId].buyer=msg.sender;
	(bool success, ) = bob.call.value(coffees[_coffeeId].price)("");
	require(success);
    
	return _coffeeId;
}



}
