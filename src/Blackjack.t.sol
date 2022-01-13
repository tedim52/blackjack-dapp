// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test";
import "./BlackjackMock.sol";
import "./ChipToken.sol";
import "./TestPlayer.sol";

contract BlackjackTest is DSTest {
    BlackjackMock public game;
    ChipToken public token;
    address[] public players;
    TestPlayer public player1;
    TestPlayer public player2;
    TestPlayer public player3;

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

        game = new BlackjackMock(players, address(token));
        token.mint(address(this), 1000000000);

        player1.joinGame(game, token);
        player2.joinGame(game, token);
        player3.joinGame(game, token);
    }

    function testValidBet() public {
        player1.bet(5);

        (bool betMade, , uint256 betValue, ) = game.getPlayerInfo(
            address(player1)
        );

        assertTrue(betMade);
        assertEq(betValue, 5);
        assertEq(token.balanceOf(address(this)), 1000000005);
        assertEq(0, uint256(game.getCurrentStage())); /// 0 == Stage.BETTING
    }

    function testValidBetsAdvancesStage() public {
        player1.bet(5);
        player2.bet(5);
        player3.bet(5);

        assertEq(1, uint256(game.getCurrentStage())); /// 1 == Stage.DEALING
    }

    function testFailInvalidBetBecauseInsufficientFunds() public {
        player1.bet(200);
    }

    function testFailInvalidBetBecauseNotAPlayer() public {
        TestPlayer player4 = new TestPlayer();
        player4.bet(5);
    }

    function testFailInvalidBetBecauseBetAlreadyMade() public {
        player1.bet(5);
        player1.bet(5);
    }

    function testCorrectNumberOfCardsAreDealt() public {
        game.setGameState(address(player1), 3, 0, 1);

        game.deal();

        assertEq(game.getNumCardsInDeck(), 44);
    }
    // 3 players = 6 cards + 2 dealer cards = 8 cards
    // test that all players have greaten than zero stack values
    // test that we advance to the next stage

    // add tests for checking naturals
    // need to create BlackjackMock contract to mock dealer and player stack values

    // add tests for playing
    // test that is doesn't work for someone whos not a player
    // test that only current player can play
    // test that players turn is over after stand
    // test that players turn is over after a bust
    // test that current player is moved when turn is over

    // add tests for payout
    // need to create BlackjackMock contract to mock dealer and player stack values
    // stage advances
}
