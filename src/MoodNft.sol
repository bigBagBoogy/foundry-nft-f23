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
    string private s_trophy;
    // string private s_happySvgUri;

    // mapping(uint256 => NFTState) private s_tokenIdToState;

    event CreatedNFT(uint256 indexed tokenId);

    constructor(string memory trophy) ERC721("Throphy", "NFT") {
        s_tokenCounter = 0;
        s_trophy = trophy;
        // s_happySvgUri = happySvgUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        emit CreatedNFT(s_tokenCounter);
    }

    // function flipMood(uint256 tokenId) public {
    //     if (!_isApprovedOrOwner(msg.sender, tokenId)) {
    //         revert MoodNft__CantFlipMoodIfNotOwner();
    //     }

    //     if (s_tokenIdToState[tokenId] == NFTState.HAPPY) {
    //         s_tokenIdToState[tokenId] = NFTState.SAD;
    //     } else {
    //         s_tokenIdToState[tokenId] = NFTState.HAPPY;
    //     }
    // }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) {
            revert ERC721Metadata__URI_QueryFor_NonExistentToken();
        }
        string memory imageURI = s_trophy;

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT for the monthly top-score, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "gold", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    // function getHappySVG() public view returns (string memory) {
    //     return s_happySvgUri;
    // }

    // function getSadSVG() public view returns (string memory) {
    //     return s_sadSvgUri;
    // }
    function getTrophySVG() public view returns (string memory) {
        return s_trophy;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
