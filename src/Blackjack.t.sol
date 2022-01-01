// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Blackjack.sol";
import "./ChipToken.sol";

contract BlackjackTest is DSTest {
    Blackjack game;
    ChipToken token;
    address[] players;
    address player1;
    address player2;

    function setUp() public {
        token = new ChipToken("Chip", "CHIP");
        address factory = 0x86cCF97148155f22273Fe1099EfA2dbA3C1D85bB; // should be address of factor contract
        player1 = 0xa5E7C6d8d6e9bC4eEfD9CdD600DdeF0e8947e436;
        player2 = 0xB6Fc005dFa57DbED7AC390e89E6ceB487f1B5a10;
        players.push(player1);
        players.push(player2);
        token.mint(player1, 1000000000);
        token.mint(player2, 1000000000);
        token.increaseAllowance(player2, 1000000000);

        game = new Blackjack(players, factory, address(token));
        token.increaseAllowance(address(game), 1000000000);
    }

    function test_valid_bet() public {
        game.bet(player1, 500000);

        (, bool betMade, , uint256 betValue, ) = game.getPlayer(player1);
        assertTrue(betMade);
        assertEq(betValue, 500000);
    }
}
