// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {Trophya} from "../src/Trophya.sol";

contract DeployTrophya is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (Trophy) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        string memory svg = vm.readFile("./images/zombieblue.svg");

        vm.startBroadcast(deployerKey);
        Trophya trophya = new Trophya(          
            svgToImageURI(svg)           
        );
        vm.stopBroadcast();
        return trophya;
    }

    function svgToImageURI(string memory trophySvg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64EncodedTropy = Base64.encode(bytes(string(abi.encodePacked(trophySvg))));
        // string memory result = string(abi.encodePacked(baseURL, svgBase64EncodedTropy));
        // console.log(result);
        return string(abi.encodePacked(baseURL, svgBase64EncodedTropy));
    }
}
