// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// Fund
// Widthdraw

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        vm.startBroadcast();
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.stopBroadcast();
        fundFundMe(mostRecentlyDeployed);
    }
}

contract WithDrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    // The line FundMe(payable(mostRecentlyDeployed)).withdraw(); is calling the withdraw function on a contract instance of FundMe at the address mostRecentlyDeployed. The payable keyword is used to allow the contract to receive Ether

    function run() external {
        vm.startBroadcast();
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.stopBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
    }
}
