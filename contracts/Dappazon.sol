// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    //code
    address public owner;

    struct Item {
        uint256 id;
        string name;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
        uint256 stock;
    }

    struct Order {
        uint256 time;
        Item item;
    }

    mapping(uint256 => Item) public items;
    mapping(address => uint256) public orderCount;
    mapping(address => mapping(uint256 => Order)) public orders;

    event List(string name, uint256 cost, uint256 quantity);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    //0, 1, ......

    //List Product
    function list(
        uint256 _id,
        string memory _name,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock
    ) public onlyOwner {
        //code

        //create Item struct
        Item memory item = Item(
            _id,
            _name,
            _category,
            _image,
            _cost,
            _rating,
            _stock
        );

        //save item struct to blockchain
        items[_id] = item;

        //Emit an event
        emit List(_name, _cost, _stock);
    }

    //Buy Product

    function buy(uint256 _id) public payable {
        // Receive Crypto

        //Fetch Item
        Item memory item = items[_id];

        //Creat an order
        Order memory order = Order(block.timestamp, item);

        //Save order to chain
        orderCount[msg.sender]++; // <-- Order ID
        orders[msg.sender][orderCount[msg.sender]] = order;

        //Substrack stock
        items[_id].stock = item.stock - 1;

        //Emit event
    }

    //Withdraw Funds
}
