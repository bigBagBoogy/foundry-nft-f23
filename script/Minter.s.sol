// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Trophy} from "../src/Trophy.sol";

contract Minter is Script {
    function run() external {
        // player, contractAddress
        address winner = pickOneOfTwo();
        mintNftOnContract(winner, 0x1288cd7D89f29350c1D28D4A617557da2b8437B0);
    }
    // gold:  0xd3e20C1942828d60310F6ddC4547ff736819Aff9
    // silver: 0x7a0902f2BB39AC88b275c9Aa044E0E486FA014CF
    // bronze:  0x017B5b379415036808C20989fAbBE40834c98a46
    // account 3 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
    // brave  0xAe5C5446bA2F4ad7BeDb8A79B02569719e609a6c

    function mintNftOnContract(address player, address trophyAddress) public {
        vm.startBroadcast();
        Trophy(trophyAddress).mintNft(player);
        vm.stopBroadcast();
    }

    function pickOneOfTwo() public view returns (address winner) {
        address player1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        address player2 = 0xAe5C5446bA2F4ad7BeDb8A79B02569719e609a6c;
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 2;
        if (randomNumber == 0) {
            return player1;
        }
        return player2;
    }
}
