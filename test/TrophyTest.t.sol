// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// import {DeployTrophy} from "../script/DeployTrophy.s.sol";
import {Trophy} from "../src/Trophy.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract TrophyTest is StdCheats, Test {
    string constant NFT_NAME = "Trophy";
    string constant NFT_SYMBOL = "GMM";
    Trophy public trophy;
    bool public open = true;

    address public constant USER = address(1);
    address public constant USER2 = address(2);

    function setUp() public {
        trophy = new Trophy(NFT_NAME, NFT_SYMBOL); // Deploy Trophy directly
        open = true;
    }

    function test_CanMintToAnyAddress() public {
        vm.prank(USER);
        trophy.mintNFT(USER2, "test"); //mint to other
    }

    function test_CanMintAndHaveABalance() public {
        vm.prank(USER);
        trophy.mintNFT(USER, "test");

        assert(trophy.balanceOf(USER) == 1);
    }

    function test_cannotMintASecondTime() public {
        vm.prank(USER);
        trophy.mintNFT(USER, "test1");
        trophy.mintNFT(USER, "test2");
        assert(trophy.balanceOf(USER) == 1);
    }

    function test_anyAddressCanMint() public {
        vm.prank(USER2);
        trophy.mintNFT(USER, "test1");
        assert(trophy.balanceOf(USER) == 1);
    }

    function test_OnlyOwnerCanSetPermission() public {
        // Attempt to set permission from a non-owner account
        vm.prank(USER2);

        // Try to call setPermission on the trophy contract
        try trophy.setPermission() {
            assert(false);
        } catch Error(string memory) {
            // Expected behavior, non-owner should not be able to set permission
        }
    }

    // Now try with the owner account
    function test_ownerCanSetPermission() public {
        bool isOpen = open;
        vm.prank(USER);
        // Attempt to call setPermission
        trophy.setPermission();
        // Ensure the call was successful (onlyOwner should allow it)
        assert(isOpen);
    }

    function test_CannotMintWhenClosed() public {
        // Ensure minting is initially not allowed
        bool success = address(trophy).call(trophy.mintNFT.selector, USER, "test");

        // Ensure the call was unsuccessful
        assert(!success, "Minting was allowed when closed");

        // Set permission to open minting
        vm.prank(USER);
        deployer.setPermission();

        // Attempt to mint again
        vm.prank(USER);
        success = address(trophy).call(trophy.mintNFT.selector, USER, "test");

        // Ensure the call was successful (minting should be allowed now)
        assert(success, "Minting was not allowed when open");
    }

    function test_CreatedNFTEvent() public {
        // Set permission to open minting
        vm.prank(USER);
        deployer.setPermission();

        // Mint an NFT
        vm.prank(USER);
        (bool success, bytes memory data) = address(trophy).call(trophy.mintNFT.selector, USER, "test");

        // Ensure the call was successful
        assert(success, "Minting was not allowed when open");

        // Check if the CreatedNFT event was emitted
        (,,,, uint256 tokenId) = abi.decode(data, (address, bytes32, bytes, bytes32, uint256));
        assert(tokenId > 0, "CreatedNFT event not emitted");
    }
}
