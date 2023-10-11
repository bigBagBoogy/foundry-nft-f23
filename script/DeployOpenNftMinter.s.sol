// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {OpenNftMinter} from "../src/OpenNftMinter.sol";

contract DeployOpenNftMinter is Script {
    uint256 public deployerKey;

    // Gas limit for deployment
    uint256 public gasLimit;

    function run() external returns (OpenNftMinter) {
        deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        OpenNftMinter openNftMinter = new OpenNftMinter("OpenNft", "BBB");
        vm.stopBroadcast();
        return openNftMinter;
    }
}
