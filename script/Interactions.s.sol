// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public returns (uint256, address) {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoodinator = helperConfig.getConfig().vrfCoordinator;
        (uint256 subId,) = createSubscription(vrfCoodinator);
        return (subId, vrfCoodinator);
    }

    function createSubscription(address vrfCoodinator) public returns (uint256, address) {
        console.log("Creating subscription on chain Id: ", block.chainid);
        vm.startBroadcast();
        uint256 subId = VRFCoordinatorV2_5Mock(vrfCoodinator).createSubscription();
        vm.stopBroadcast();

        console.log("Your subscription ID is: ", subId);
        console.log("Please update your subscription id in your HelperConfig.s.sol");
        return (subId, vrfCoodinator);
    }

    function run() public {
        createSubscriptionUsingConfig();
    }
}
