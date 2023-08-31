// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Trophy is ERC721URIStorage, Ownable {
    uint256 private s_tokenCounter;
    //How about we add a state variable-"flag" called onlyOwnerOn and set it to false. Then we can write a function called "setPermission" which will be onlyOwner, that can be called by only me and sets "onlyOwnerOn" to true.
    bool public open = true;

    event CreatedNFT(uint256 indexed tokenId);

    constructor(string memory name, string memory token) ERC721(name, token) {
        s_tokenCounter = 0;
    }

    function setPermission() external onlyOwner {
        open = !open; // Toggle the value
    }

    function mintNFT(address to, string memory tokenURI) external {
        require(open == true, "Minting not allowed yet");
        open = false;
        uint256 tokenId = s_tokenCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        s_tokenCounter++;
        emit CreatedNFT(s_tokenCounter);
    }
}
