// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
// import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
// import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

// contract MintBasicNft is Script {
//     string public constant PUG_URI =
//         "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
//     uint256 deployerKey;

//     function run() external {
//         address mostRecentlyDeployedBasicNft = DevOpsTools
//             .get_most_recent_deployment("BasicNft", block.chainid);
//         mintNftOnContract(mostRecentlyDeployedBasicNft);
//     }

//     function mintNftOnContract(address basicNftAddress) public {
//         vm.startBroadcast();
//         BasicNft(basicNftAddress).mintNft(PUG_URI);
//         vm.stopBroadcast();
//     }
// }

contract MintMoodNft is Script {
    function run() external {
        mintNftOnContract(0x017B5b379415036808C20989fAbBE40834c98a46);
    }
    // gold:  0xd3e20C1942828d60310F6ddC4547ff736819Aff9
    // silver: 0x7a0902f2BB39AC88b275c9Aa044E0E486FA014CF
    // bronze:  0x017B5b379415036808C20989fAbBE40834c98a46

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

// contract FlipMoodNft is Script {
//     uint256 public constant TOKEN_ID_TO_FLIP = 0;

//     function run() external {
//         flipMoodNft(0x262f51d97183dE5e2527e35f695353f454e054FF);
//     }

//     function flipMoodNft(address moodNftAddress) public {
//         vm.startBroadcast();
//         MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
//         vm.stopBroadcast();
//     }
// }
