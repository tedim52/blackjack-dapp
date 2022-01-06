// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.4.23;

import "ds-test/test.sol";
import "./ChipToken.sol";

contract TestChipToken is DSTest {
    ChipToken token;
    address player1;

    function setUp() public {
        token = new ChipToken("ChipToken", "CHIP");
        player1 = 0x510B8220635b4CdFc2B1Ee4657A7D9515B64729A;
    }

    function test_minting_to_address() public {
        token.mint(player1, 100000000);
        assertEq(100000000, token.balanceOf(player1));
    }

    /// TODO: add tests for minter and transfer role functionality
}
