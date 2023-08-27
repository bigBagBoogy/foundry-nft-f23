// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {console} from "forge-std/console.sol";

contract DeployMoodNft is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (MoodNft) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        string memory trophySvg = vm.readFile("./images/trophy.svg");
        // string memory gold2Svg = vm.readFile("./images/trophygold2.svg");

        vm.startBroadcast(deployerKey);
        MoodNft moodNft = new MoodNft(
            // svgToImageURI(sadSvg),
            // svgToImageURI(happySvg)
            svgToImageURI(trophySvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    // example:
    // '<svg width="500" height="500" viewBox="0 0 285 350" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill="black" d="M150,0,L75,200,L225,200,Z"></path></svg>'
    // would return ""
    // You could also just upload the raw SVG and have solildity convert it!

    function svgToImageURI(string memory trophySvg) public view returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64EncodedTropy = Base64.encode(bytes(string(abi.encodePacked(trophySvg))));
        string memory result = string(abi.encodePacked(baseURL, svgBase64EncodedTropy));
        console.log(result);
        return string(abi.encodePacked(baseURL, svgBase64EncodedTropy));
    }
}

//  space-invader:
//  data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCg0KPCEtLSBVcGxvYWRlZCB0bzogU1ZHIFJlcG8sIHd3dy5zdmdyZXBvLmNvbSwgR2VuZXJhdG9yOiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJJY29ucyIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgDQoJIHZpZXdCb3g9IjAgMCAzMiAzMiIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8c3R5bGUgdHlwZT0idGV4dC9jc3MiPg0KCS5zdDB7ZmlsbDpub25lO3N0cm9rZTojMDAwMDAwO3N0cm9rZS13aWR0aDoyO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2UtbWl0ZXJsaW1pdDoxMDt9DQo8L3N0eWxlPg0KPHBhdGggZD0iTTMxLDE2aC0ydi0yYzAtMC42LTAuNC0xLTEtMWgtMnYtMmMwLTAuNi0wLjQtMS0xLTFoLTJWOGgyYzAuNiwwLDEtMC40LDEtMVY0YzAtMC42LTAuNC0xLTEtMWgtM2MtMC42LDAtMSwwLjQtMSwxdjJoLTINCgljLTAuNiwwLTEsMC40LTEsMXYzaC00VjdjMC0wLjYtMC40LTEtMS0xaC0yVjRjMC0wLjYtMC40LTEtMS0xSDdDNi40LDMsNiwzLjQsNiw0djNjMCwwLjYsMC40LDEsMSwxaDJ2Mkg3Yy0wLjYsMC0xLDAuNC0xLDF2Mkg0DQoJYy0wLjYsMC0xLDAuNC0xLDF2MkgxYy0wLjYsMC0xLDAuNC0xLDF2OWMwLDAuNiwwLjQsMSwxLDFoM2MwLjYsMCwxLTAuNCwxLTF2LTVoMXY1YzAsMC42LDAuNCwxLDEsMWgydjJjMCwwLjYsMC40LDEsMSwxaDQNCgljMC42LDAsMS0wLjQsMS0xdi0zYzAtMC42LTAuNC0xLTEtMWgtM3YtMWgxMHYxaC0zYy0wLjYsMC0xLDAuNC0xLDF2M2MwLDAuNiwwLjQsMSwxLDFoNGMwLjYsMCwxLTAuNCwxLTF2LTJoMmMwLjYsMCwxLTAuNCwxLTF2LTUNCgloMXY1YzAsMC42LDAuNCwxLDEsMWgzYzAuNiwwLDEtMC40LDEtMXYtOUMzMiwxNi40LDMxLjYsMTYsMzEsMTZ6IE0xNCwxOWMwLDAuNi0wLjQsMS0xLDFoLTNjLTAuNiwwLTEtMC40LTEtMXYtM2MwLTAuNiwwLjQtMSwxLTENCgloM2MwLjYsMCwxLDAuNCwxLDFWMTl6IE0yMywxOWMwLDAuNi0wLjQsMS0xLDFoLTNjLTAuNiwwLTEtMC40LTEtMXYtM2MwLTAuNiwwLjQtMSwxLTFoM2MwLjYsMCwxLDAuNCwxLDFWMTl6Ii8+DQo8L3N2Zz4=
