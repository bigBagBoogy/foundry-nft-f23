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
    uint256 private s_tokenCounter = 0;

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
        assert(trophy.balanceOf(USER) == 1);
        vm.expectRevert("Minting not allowed yet");
        trophy.mintNFT(USER, "test2");
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
        // Attempt to call setPermission by trophy, which is owner
        trophy.setPermission();
        // Ensure the call was successful (onlyOwner should allow it)
        assert(isOpen);
    }

    //!!!!!!!!!!!  below example of wrong logic    !!!!!!!!!!!!!// see way below explanation
    // function test_CannotMintWhenClosed() public {
    //     // Ensure minting is not allowed when closed
    //     open = false;
    //     // Ensure the call was unsuccessful
    //     vm.expectRevert("Minting not allowed yet");
    //     trophy.mintNFT(USER, "test");
    // }
    //!!!!!!!!!!!  above example of wrong logic    !!!!!!!!!!!!!// see way below explanation

    function test_CannotMintWhenClosed() public {
        // Close minting by calling setPermission
        trophy.setPermission();

        // Ensure the call was unsuccessful
        vm.expectRevert("Minting not allowed yet");
        trophy.mintNFT(USER, "test");
    }
}
// You set open to false, expecting that minting should not be allowed, and you expect a revert with the message "Minting not allowed yet."

// The issue here seems to be that the open state variable is directly modified in the test, but the state of the smart contract isn't updated. In Ethereum, state changes in the blockchain are not reflected immediately; they require a transaction to be mined. When you modify open in the test, it's only changed in the test environment, not in the deployed smart contract.

// To properly test the behavior of the smart contract when it's closed for minting, you should use the setPermission function to toggle the open state within your test.
