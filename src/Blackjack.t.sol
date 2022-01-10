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

    function setUp() public {
        token = new ChipToken();
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

        player1.joinGame(game, token);
        player2.joinGame(game, token);
        player3.joinGame(game, token);
    }

    function test_valid_bet() public {
        player1.bet(5);

        (bool betMade, , uint256 betValue, ) = game.getPlayerInfo(
            address(player1)
        );

        assertTrue(betMade);
        assertEq(betValue, 5);
        assertEq(token.balanceOf(address(game)), 1000000005);
        assertEq(0, uint256(game.getCurrentStage())); /// 0 == Stage.BETTING
    }

    function test_valid_bet_advances_stage() public {
        player1.bet(5);
        player2.bet(5);
        player3.bet(5);

        assertEq(1, uint256(game.getCurrentStage())); /// 1 == Stage.DEALING
    }

    function testFail_invalid_bet_because_insufficient_funds() public {
        player1.bet(200);
    }

    function testFail_invalid_bet_because_not_a_player() public {
        TestPlayer player4 = new TestPlayer();
        player4.bet(5);
    }

    function testFail_invalid_bet_becuase_bet_already_made() public {
        player1.bet(5);
        player1.bet(5);
    }

    // add tests for checking naturals

    // add tests for dealing

    // add tests for playing
}
