// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/fundeMe.sol";

contract DeployFundMe is Script {
    function run() external {
        vm.startBroadcast();
        FundMe fundMe = new FundMe();
        console.log("Deployed FundMe at address: ", address(fundMe));
        vm.stopBroadcast();
    }
}
