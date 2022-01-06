// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Blackjack.sol";
import "./ChipToken.sol";
import "./TestPlayer.sol";

contract BlackjackTest is DSTest {
    Blackjack game;
    ChipToken token;
    address[] players;
    TestPlayer player1;
    TestPlayer player2;
    TestPlayer player3;

    // create a TestableChipToken that overrides the approve functionality?
    function setUp() public {
        token = new ChipToken("Chip", "CHIP");
        player1 = new TestPlayer();
        player2 = new TestPlayer();
        player3 = new TestPlayer();
        players.push(address(player1));
        players.push(address(player2));
        players.push(address(player3));
        token.mint(players[0], 100);
        token.mint(players[1], 100);
        token.mint(players[2], 100);

        game = new Blackjack(players, address(token));
        token.mint(address(game), 1000000000);

        player1.join_game(game, token);
        player2.join_game(game, token);
        player3.join_game(game, token);
    }

    function test_valid_bet() public {
        player1.bet(5);

        (bool betMade, , uint256 betValue, ) = game.getPlayerInfo(
            address(player1)
        );
        assertTrue(betMade);
        assertEq(betValue, 5);
    }
}
