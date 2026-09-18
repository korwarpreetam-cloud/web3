////// count function 
pragma solidity ^0.8.0;


contract Counter{
    // counter app so it is gonna store the numerical value and 
    //increase
    // decrese 
    string public name = "kanav";
    uint public count=1; // state variable usigned integer public means it is general and you will abel to fetch
    
    constructor(string memory _name, uint _initialcount){
        name = _name;
        count= _initialcount;
    }
    function increment() public returns (uint newCount){
        count=count+1;
        return count;

    }
    function decrement() public returns (uint newCount){
        count=count-1;
        return count;
    }





}
###count cant go below zero because it is unasigned integer 








///////////////////////////////// first smart contract /////////////////////////////////////////////////////

pragma solidity ^0.8.0;


contract Counter{
    // counter app so it is gonna store the numerical value and 
    //increase
    // decrese 
    string public name = "kanav";
    uint public count=1; // state variable usigned integer public means it is general and you will abel to fetch
    
    constructor(string memory _name, uint _initialcount){
        name = _name;
        count= _initialcount;
    }
    function increment() public returns (uint newCount){
        count=count+1;
        return count;

    }
    function decrement() public returns (uint newCount){
        count=count-1;
        return count;
    }
    ///it only reads it cannot edit 
    function getCount() public view returns (uint){
        return count;
    }
    function setName(string memory _newName) public returns(string memory newName){
        name = _newName;
        return name;
    }





}
/////////////////////////////////////////////////////////////////////////////////////////
counter.js 
 const {expect} = require('chai');
 const {ethers} = require('hardhat');
const { describe } = require('node:test');

 describe('Counter',()=>{

    it('stores the count', async ()=>{
        const Counter= await ethers.getContractFactory('Counter')
        const counter = await Counter.deploy('MyCounter',1);
        
        const count = await counter.count();
        expect(count).to.equal(2)

    })
 })

 hardhat testing for the contract 
 In a Hardhat test, const { expect } = require('chai') imports Chai’s expect() function for checking results, while const { ethers } = require('hardhat') gives us Ethers.js tools to interact with smart contracts, and describe() groups related tests together. Inside describe('Counter', ...), it('stores the count', async () => {}) defines one test, where async allows us to use await for blockchain operations. ethers.getContractFactory('Counter') gets the factory for the compiled Counter contract, and Counter.deploy('MyCounter', 1) deploys a new instance of that contract with the constructor arguments "MyCounter" and 1. The deployed contract is stored in counter, and await counter.count() calls the contract's automatically generated getter for the public count variable and stores its value in count. Finally, expect(count).to.equal(2) checks that the actual value returned by the contract is 2; if it is 2, the test passes, otherwise it fails. Easy flow to remember: Get Factory → Deploy Contract → Call Function → Check Result.



 /////
 method 2 more optimised 
  const {expect} = require('chai'); *** {chai is an assertion/testing library.} 
 const {ethers} = require('hardhat'); ***which lets your JavaScript test interact with your Solidity smart contract.
const { describe, beforeEach } = require('node:test');

 describe('Counter',()=>{
    let counter;

    beforeEach(async ()=>{.   ***Run this code before every it() test.
        const Counter= await ethers.getContractFactory('Counter')
        counter = await Counter.deploy('MyCounter',1);
    })

    describe('Deployment', ()=>{
        it('sets initial count', async ()=>{
     
        
        const count = await counter.count();
        expect(count).to.equal(2)

    })
    it('sets initial name', async ()=>{
     
        
        const name = await counter.name();
        expect(name).to.equal("MyCounter")

    })

    })

    
 })

///////////////////////
 const {expect} = require('chai');
 const {ethers} = require('hardhat');
const { describe, beforeEach } = require('node:test');

 describe('Counter',()=>{
    let counter;

    beforeEach(async ()=>{
        const Counter= await ethers.getContractFactory('Counter')
        counter = await Counter.deploy('MyCounter',1);
    })

    describe('Deployment', ()=>{
        it('sets initial count', async ()=>{
     
        
        const count = await counter.count();
        expect(count).to.equal(2)

    })
    it('sets initial name', async ()=>{
     
        
        const name = await counter.name();
        expect(name).to.equal("MyCounter")

    })

    })
    describe('Counting',()=>{
        let transaction
        it('reads the count from the "count" public variable',async()=>{
            expect(await counter.count()).to.equal(1);
        } )
        it('reads the count from the "getCount" function',async()=>{
            expect(await counter.getCount()).to.equal(1);
        } )
        it('increments the count',async()=>{
             transaction = await counter.increments();
            await  transaction.wait();
            expect(await counter.count()).to.equal(2);

            transaction = await counter.increments();
            await  transaction.wait();
            expect(await counter.count()).to.equal(3);

        })
        it('decrements the count',async()=>{
             transaction = await counter.decrement();
            await  transaction.wait();
            expect(await counter.count()).to.equal(0);

         

        })
        it('reads the name from the "name" public variable',async()=>{
            expect(await counter.name()).to.equal("MyCounter");
        } )
        it('reads the name from the "gatName" function',async()=>{
            expect(await counter.getName()).to.equal("MyCounter");
        } )
        it ("updates the name", async()=>{
            transaction = await counter.setName(" New Name")
            await transaction.wait()
            expect(await counter.name()).to.equal("New Name")
        })
    })

    
 })








/////////////////////////////////////////////////////////////////////////
nft's

Escrow.sol 
pragma solidity ^0.8.0;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) external;
}

contract Escrow {
    address public nftAdress;
    uint256 public nftID;
    uint256 public purchasePrice;
    uint256 public escrowAmount;
    address public seller;
    address public buyer;
    address public inspector;
    address public lender;

    modifier onlybuyer(){
         require(msg.sender==buyer,"only buyer can call this function");
         _;

    }
     modifier onlyinspector(){
         require(msg.sender==inspector,"only inspector can call this function");
         _;

    }

    bool public inpectionPassed = false;

    constructor(
        address _nftAdress,
        uint256 _nftID,
        uint256 _purchasePrice,
        uint256 _escrowAmount,
        address payable _seller,
        address payable _buyer,
        address inspector,
        address lender
    ) {
        nftAdress = _nftAdress;
        nftID = _nftID;
        purchasePrice=_purchasePrice;
        escrowAmount=_escrowAmount;
        seller = _seller;
        buyer = _buyer;
        inspector=_inspector;
        lender=_lender;

    }

    

    function depositEarnest() public payable onlybuyer {
        require(msg.value>=escrowAmount);
       

    }
    function updateInsceptionStatus(bool _passed) public onlyinspector{ 
        insceptionPassed=_passed;
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function finalSale() public {
        IERC721(nftAdress).transferFrom(
            seller,
            buyer,
            nftID
        );
    }
}


---------------------------------------------------------------------------
realestate.js
const { expect } = require("chai");
const { ethers } = require("hardhat");

const token=(n)=>{
    return ethers.utils.praseUnits(n.toString(),'ether')
}
const ether = tokens

describe("RealEstate", () => {
    let realEstate, escrow;
    let deployer, seller, buyer;
    let nftid = 1;
    let purchase = ether(100)
    let escrowAmount=ether(20)

    beforeEach(async () => {

        // Get test accounts
        accounts = await ethers.getSigners();

        deployer = accounts[0];
        seller = accounts[0];
        buyer = accounts[1];
        inspector=accounts[2];
        lender = accounts[3];

        // Get contract factories
        const Realestate = await ethers.getContractFactory("Realestate");
        const Escrow = await ethers.getContractFactory("Escrow");

        // Deploy RealEstate NFT contract
        realEstate = await Realestate.deploy();

        // Deploy Escrow contract
        escrow = await Escrow.deploy(
            realEstate.address,
            nftid,
            purchase,
            escrowAmount,
            seller.address,
            buyer.address,
            inspector.address,
            lender.address
        );

        // Seller gives Escrow permission to transfer NFT #1
        transaction = await realEstate
            .connect(seller)
            .approve(escrow.address, nftid);

        await transaction.wait();
    });

    describe("Development", () => {

        it("NFT is owned by seller", async () => {

            expect(
                await realEstate.ownerOf(nftid)
            ).to.equal(seller.address);

        });

    });

    describe("Selling real estate", () => {
        let balance , transaction

        it("transfers NFT from seller to buyer", async () => {

            // Before sale
            expect(
                await realEstate.ownerOf(nftid)
            ).to.equal(seller.address);

            // buyer deposit earnest 
            transaction = await escrow.connect(buyer).depositEarnest({value: escrowAmount})

            //check escrow balance 
            balance = await escrow.getBalance()
            console.log("escrow balance:", ethers.utils.formatEther(balance))

            //inspector update staus 
            transaction = await escrow.connect(inspector).updateInspectionStatus(true)
            await transaction.wait()
            console.log("inspector updates status ")

            // Buyer finalizes the sale
            transaction = await escrow
                .connect(buyer)
                .finalSale();

            await transaction.wait();

            // After sale
            expect(
                await realEstate.ownerOf(nftid)
            ).to.equal(buyer.address);

        });

    });

});




pragma solodity^0.8.0;

interface IERC721{
    function transferForm(
        address _from,
        address _to,
        uint256 _id
    ) external;
}

contract Escrow{
    address public nftAdress;
    uint256 public nftId;
    uint256 public purchasePrice;
    uint256 public escrowAmount;
    address public seller;
    address public buyer;
    address public inspector;
    address public lender;

    bool public inspectionPassed = false;

    constructor(
        address _nftAddress,
        uint256 _nftId,
        uint256 _purchasePrice,
        uint256 _escrowAmount,
        address payable _seller,
        address payable _buyer,
        address inspector,
        address lender
    ){
        nftAdress = _nftAddress;
        nftId= _nftId;
        purchasePrice =_purchasePrice;
        escrowAmount = _escrowAmount;
        seller = _seller;
        buyer = _buyer;
        inspector = _inspector;
        lender = _lender;
    }

    function depositEarnest() public payable onlybuyer{
        require(msg.value>=)
    }
}