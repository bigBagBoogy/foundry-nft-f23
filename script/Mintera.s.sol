// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Trophya} from "../src/Trophya.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract Mintera is Script {
    function run() external {
        string memory svg = vm.readFile("./images/zombiegreener.svg");
        address winner = pickOneOfTwo();
        // player, trophyaAddress
        mintNftOnContract(winner, 0x5b24C9A4A3f3b6dA228707C44710208Ae8229839, svg);
    }

    function mintNftOnContract(address winner, address trophyaAddress, string memory svg) public {
        vm.startBroadcast();
        Trophya(trophyaAddress).mintNFT(winner, svgToTokenURI(svg));
        vm.stopBroadcast();
    }

    // function svgToImageURI(string memory svg) public pure returns (string memory) {
    //     string memory baseURL = "data:image/svg+xml;base64,";
    //     string memory svgBase64EncodedSvg = Base64.encode(bytes(string(abi.encodePacked(svg))));
    //     string memory result = string(abi.encodePacked(baseURL, svgBase64EncodedSvg));
    //     tokenURI(result);
    //     return string(abi.encodePacked(baseURL, svgBase64EncodedSvg));
    // }
    function svgToTokenURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64EncodedSvg = Base64.encode(bytes(string(abi.encodePacked(svg))));
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64EncodedSvg));
        return string(
            abi.encodePacked(
                baseURL,
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"winner", "description":"An NFT for the monthly top-score, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "Monthly Winner", "value": 200}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
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
