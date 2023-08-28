// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Trophya is ERC721URIStorage, Ownable {
    uint256 private s_tokenCounter;

    event CreatedNFT(uint256 indexed tokenId);

    constructor(string memory name, string memory token) ERC721(name, token) {
        s_tokenCounter = 0;
    }

    function mintNFT(address to, string memory tokenURI) external onlyOwner {
        uint256 tokenId = s_tokenCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        s_tokenCounter++;
        emit CreatedNFT(s_tokenCounter);
    }
}
