// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721, Ownable {
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    // error MoodNft__CantFlipMoodIfNotOwner();

    // enum NFTState {
    //     HAPPY,
    //     SAD
    // }

    uint256 private s_tokenCounter;
    // string private s_trophyGold;
    string private s_trophySilver;
    // string private s_trophyBronze;

    // mapping(uint256 => NFTState) private s_tokenIdToState;

    event CreatedNFT(uint256 indexed tokenId);

    constructor(string memory trophySilver) ERC721("Throphy", "NFT") {
        s_tokenCounter = 0;
        // s_trophyGold = trophyGold;
        s_trophySilver = trophySilver;
        // s_trophyBronze = trophyBronze;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        emit CreatedNFT(s_tokenCounter);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        string memory imageURI = s_trophySilver;
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(), // Customize name if needed
                            '", "description":"An NFT for the monthly top-score, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "Monthly Winner", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    // function getGoldTrophySVG() public view returns (string memory) {
    //     return s_trophyGold;
    // }

    function getSilverTrophySVG() public view returns (string memory) {
        return s_trophySilver;
    }

    // function getBronzeTrophySVG() public view returns (string memory) {
    //     return s_trophyBronze;
    // }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
