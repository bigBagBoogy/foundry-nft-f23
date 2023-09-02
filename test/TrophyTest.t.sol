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
            assert(false, "Non-owner was able to set permission");
        } catch Error(string memory) {
            // Expected behavior, non-owner should not be able to set permission
        }
    }

    // Now try with the owner account
    function test_ownerCanSetPermission() public {
        open = false;
        vm.prank(USER);
        // Attempt to call setPermission
        trophy.setPermission();
        // Ensure the call was successful (onlyOwner should allow it)
        assert(open == true, "Owner was not able to set permission");
    }
    // Now try with the owner account

    function test_ownerCanSetPermission() public {
        vm.prank(USER);

        // Attempt to call setPermission on the trophy contract
        trophy.setPermission();

        // Access the open variable from the trophy contract to check if it was updated
        bool isOpen = trophy.open();

        // Ensure the open variable was updated to true (onlyOwner should allow it)
        assert(isOpen, "Owner was not able to set permission");
    }
}
