// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {simpleStorage} from "../src/simpleStorage.sol";

contract simpleStoragescript is Script {
    function run() public {
        vm.startBroadcast();

        simpleStorage newSimpleStorage = new simpleStorage();

        vm.stopBroadcast();
    }
}
