// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./Blackjack.sol";

/// Contract to establish a testing API for Blackjack.
contract BlackjackMock is Blackjack {
    constructor(address[] memory _players, address _token)
        Blackjack(_players, _token)
    {}

    function setGameState(
        address _currentPlayer,
        uint256 _betCount,
        uint256 _moveCount,
        uint256 _currentStage
    ) public {
        game.currentPlayer = _currentPlayer;
        game.betCount = _betCount;
        game.moveCount = _moveCount;
        game.currentStage = Stage(_currentStage);
    }

    function setPlayerState(
        address playerAddress,
        bool _betMade,
        bool _turnOver,
        uint256 _betValue,
        uint256 _stackValue
    ) public {
        Player storage player = players[playerAddress];
        player.betMade = _betMade;
        player.turnOver = _turnOver;
        player.betValue = _betValue;
        player.stackValue = _stackValue;
    }

    function setDealerState(uint256 _faceUpValue, uint256 _stackValue) public {
        dealer.faceUpValue = _faceUpValue;
        dealer.stackValue = _stackValue;
    }

    function getNumCardsInDeck() public view returns (uint256) {
        return deck.numCards;
    }
}
