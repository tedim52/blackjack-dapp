// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test";
import "./ChipToken.sol";

contract TestChipToken is DSTest {
    ChipToken public token;
    address public user;

    function setUp() public {
        token = new ChipToken();
        user = 0x510B8220635b4CdFc2B1Ee4657A7D9515B64729A; // vanity address
    }

    function testMintingToAddress() public {
        token.mint(user, 100000000);
        assertEq(100000000, token.balanceOf(user));
    }

    /// TODO: add tests for minter and transfer role functionality
}
