pragma solidity ^0.4.13;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";

contract TestSupplyChain {

    // Test for failing conditions in this contracts
    // test that every modifier is working

    SupplyChain supplyChain;

    function beforeEach() {
        // supplyChain = SupplyChain(DeployedAddresses.SupplyChain());
        supplyChain = new SupplyChain();
    }

    function testOwner() {
        // Assert.equal(supplyChain.owner(), msg.sender, "Owner should be set");
        Assert.equal(supplyChain.owner(), this, "Owner should be set");
    }

    function testAddItem() {
        supplyChain.addItem("iPhone", 10);
        Assert.equal(supplyChain.items[0].name, "iPhone", "Name should be iPhone");
    }
    
    // buyItem
    // test for failure if user does not send enough funds
    // test for purchasing an item that is not for Sale
    function testBuyItem() {
        supplyChain.addItem("iPhone", 10);
        supplyChain.buyItem.value(1 ether)(0);
    }

    // shipItem
    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold
    function testShipItem() {
        supplyChain.addItem("iPhone", 10);
        supplyChain.buyItem.value(1 ether)(0);
        supplyChain.shipItem(0);
    }
    
    // receiveItem
    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped
    function testReceiveItem() {
        supplyChain.addItem("iPhone", 10);
        supplyChain.buyItem.value(1 ether)(0);
        supplyChain.shipItem(0);
        supplyChain.receiveItem(0);
    }

}
