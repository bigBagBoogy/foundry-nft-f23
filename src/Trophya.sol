// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CustomNFT is ERC721URIStorage, Ownable {
    constructor(string memory ZobieTropy, string memory GMM) ERC721(ZobieTropy, GMM) {
        tokenCounter = 0;
    }

    function mintNFT(address to, uint256 tokenId, string memory tokenURI) external onlyOwner {
        uint256 tokenId = tokenCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        tokenCounter++;
    }
}
