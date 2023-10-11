// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract OpenNftMinter is ERC721URIStorage {
    uint256 private s_tokenCounter;

    event CreatedNFT(uint256 indexed tokenId);

    constructor(string memory name, string memory token) ERC721(name, token) {
        s_tokenCounter = 0;
    }

    function mintNFT(address to, string memory tokenURI) external {
        uint256 tokenId = s_tokenCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        s_tokenCounter++;
        emit CreatedNFT(s_tokenCounter);
    }
}
