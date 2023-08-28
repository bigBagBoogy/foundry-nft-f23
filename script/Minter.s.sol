// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Trophy} from "../src/Trophy.sol";

contract Minter is Script {
    function run() external {
        // player, contractAddress
        mintNftOnContract(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 0x57DCC1f32c1cA7f1F5453668746489f1fDd152C4);
    }
    // gold:  0xd3e20C1942828d60310F6ddC4547ff736819Aff9
    // silver: 0x7a0902f2BB39AC88b275c9Aa044E0E486FA014CF
    // bronze:  0x017B5b379415036808C20989fAbBE40834c98a46

    function mintNftOnContract(address player, address trophyAddress) public {
        vm.startBroadcast();
        Trophy(trophyAddress).mintNft(player);
        vm.stopBroadcast();
    }
}
