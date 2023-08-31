pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// @dev Create a new smart contract function called mintThreeNFTs that takes six parameters: the addresses of three players and their corresponding token URIs. Inside this function:
// a. Use the mintNFT function to mint NFTs individually for each player and their respective token URIs.
// b. Implement the logic to send the minted NFTs to the correct player addresses.
// This new function will ensure that when the chainlink oracle countdown fires, it will call the mintThreeNFTs function to mint and distribute NFTs to the top 3 players.

contract MintThreeNFTs is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function mintThreeNFTs(
        address player1,
        string memory tokenUri1,
        address player2,
        string memory tokenUri2,
        address player3,
        string memory tokenUri3
    ) external onlyOwner {
        uint256 tokenId1 = _tokenIdCounter;
        _safeMint(player1, tokenId1);
        _setTokenURI(tokenId1, tokenUri1);
        _tokenIdCounter++;

        uint256 tokenId2 = _tokenIdCounter;
        _safeMint(player2, tokenId2);
        _setTokenURI(tokenId2, tokenUri2);
        _tokenIdCounter++;

        uint256 tokenId3 = _tokenIdCounter;
        _safeMint(player3, tokenId3);
        _setTokenURI(tokenId3, tokenUri3);
        _tokenIdCounter++;
    }
}