// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./Blackjack.sol";

contract BlackjackMock is Blackjack {
    constructor(address[] memory _players, address _token)
        Blackjack(_players, _token)
    {}

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
        Dealer storage dealer = dealer;
        dealer.faceUpValue = _faceUpValue;
        dealer.stackValue = _stackValue;
    }
}
