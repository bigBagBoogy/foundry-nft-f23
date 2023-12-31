// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {MintThreeNFTs} from "../src/MintThreeNFTs.sol";

contract DeployMintThreeNFTs is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (MintThreeNFTs) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        vm.startBroadcast(deployerKey);
        MintThreeNFTs mintThreeNFTs = new MintThreeNFTs("Winner!", "GIG", 0xB0D9A95e06C436594b71F6a795d68F6F82299b22); // graspop idle game
        vm.stopBroadcast();
        return mintThreeNFTs;
    }
}
