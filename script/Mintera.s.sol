// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Trophya} from "../src/Trophya.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract Mintera is Script {
    function run() external {
        string memory svg = vm.readFile("./images/MetaMask_Fox.svg");
        mintNftOnContract(0xEC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f, 0x347444048601eb11081Ee6B97B417C57B2d7f740, svg);
    }

    function mintNftOnContract(address winner, address trophyaAddress, string memory svg) public {
        vm.startBroadcast();
        Trophya(trophyaAddress).mintNFT(winner, svgToTokenURI(svg));
        vm.stopBroadcast();
    }

    function svgToTokenURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64EncodedSvg = Base64.encode(bytes(svg)); // No need to encode again
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64EncodedSvg));

        string memory metadata = string(
            abi.encodePacked(
                '{"name":"winner", "description":"An NFT for the monthly top-score, 100% on Chain!", ',
                '"attributes": {"trait_type": "Monthly Winner", "value": "200"}, "image":"',
                imageURI,
                '"}'
            )
        );

        string memory metadataBase64 = Base64.encode(bytes(metadata));

        string memory tokenURI = string(abi.encodePacked("data:application/json;base64,", metadataBase64));

        return tokenURI;
    }
}
//     function pickOneOfTwo() public view returns (address winner) {
//         // address player1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
//         // address player2 = 0xAe5C5446bA2F4ad7BeDb8A79B02569719e609a6c;
//         address player1 = 0xEC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f;
//         address player2 = 0xEC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f;
//         uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 2;
//         if (randomNumber == 0) {
//             return player1;
//         }
//         return player2;
//     }
// }
