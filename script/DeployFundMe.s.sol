// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        // Before startBroadcast --> not a real trx
        HelperConfig helperConfig = new HelperConfig();
        // when returning from a struct, we need to wrap in parantheses, ex(address ethUsdPriceFeed, address ethUsdPriceFeed2, , ethUsdPriceFeed4)
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // when doing vm.startBroadcast, it makes the funder becoming the msg.sender
        // after startBroadcast --> real trx (uses gas)
        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
