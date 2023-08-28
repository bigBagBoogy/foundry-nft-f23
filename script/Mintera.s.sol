// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Trophy} from "../src/Trophy.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract Minter is Script {
    function run() external {
        // player, contractAddress
        address winner = pickOneOfTwo();
        mintNftOnContract(winner, 0x1288cd7D89f29350c1D28D4A617557da2b8437B0);
        string memory svg = vm.readFile("./images/zombieblue.svg");
    }

    function svgToImageURI(string memory trophySvg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64EncodedTropy = Base64.encode(bytes(string(abi.encodePacked(trophySvg))));
        // string memory result = string(abi.encodePacked(baseURL, svgBase64EncodedTropy));
        // console.log(result);
        return string(abi.encodePacked(baseURL, svgBase64EncodedTropy));
    }

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
