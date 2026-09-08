# Solidity & Hardhat Testing Mindmap

```mermaid
mindmap
  root((Solidity & Hardhat))
    Solidity Basics
      Pragma Directive
      Contract Structure
      Variables
        uint (Cannot be negative)
        string
        public (Auto getter)
      Constructor (Init state)
      Functions
        public
        view (Read-only)
        returns
    Hardhat Testing
      Imports
        chai (expect for assertions)
        hardhat (ethers for interaction)
        node:test (describe, it, beforeEach)
      Testing Flow
        1. Get Factory
        2. Deploy Contract
        3. Call Function
        4. Check Result
      Testing Structure
        describe (Group tests)
        it (Define test)
        beforeEach (Setup before tests)
      Transactions
        Modify state
        await tx.wait()
```

## Detailed Notes

### 1. Solidity Basics
*   **Pragma Directive:** `pragma solidity ^0.8.0;`
*   **Contracts:** Defined using `contract ContractName { ... }`
*   **State Variables:**
    *   `uint` (Unsigned Integer): Stores positive numerical values. Cannot go below zero.
    *   `string`: Used for text values.
    *   `public`: Makes the variable accessible from outside and automatically creates a getter function to fetch the value.
*   **Constructor:** Function that runs only once during contract deployment to initialize state variables.
*   **Functions:**
    *   `public`: Can be called from outside the contract.
    *   `view`: Indicates the function only reads data and does not modify the blockchain state (cannot edit).
    *   `returns (...)`: Specifies the return type of the function.

### 2. Hardhat Testing
*   **Essential Imports:**
    *   `const { expect } = require('chai');` : Imports Chai's assertion library for checking expected results against actual results.
    *   `const { ethers } = require('hardhat');` : Gives access to Ethers.js tools to interact with Solidity smart contracts from JavaScript.
    *   `const { describe, beforeEach } = require('node:test');` : Methods used to structure the tests.
*   **Testing Flow (The 4 Steps):**
    1.  **Get Factory:** `const Counter = await ethers.getContractFactory('Counter')`
    2.  **Deploy Contract:** `const counter = await Counter.deploy('MyCounter', 1);`
    3.  **Call Function:** `const count = await counter.count();`
    4.  **Check Result:** `expect(count).to.equal(2);`
*   **Test Structure Hooks:**
    *   `describe('...', () => { ... })`: Groups related tests together.
    *   `it('...', async () => { ... })`: Defines a single test case. Uses `async` to allow `await` for blockchain interactions.
    *   `beforeEach(async () => { ... })`: Runs the enclosed code before *every* `it()` test inside the block. Very useful for deploying a fresh, clean contract for each test.
*   **Handling Transactions:**
    *   When a function modifies the contract state (e.g., incrementing a counter), it creates a transaction.
    *   You must wait for the transaction to be mined before asserting the new state:
        ```javascript
        let transaction = await counter.increments();
        await transaction.wait(); // Wait for it to complete
        expect(await counter.count()).to.equal(2);
        ```
