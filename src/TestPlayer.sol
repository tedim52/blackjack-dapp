// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./Blackjack.sol";

contract TestPlayer {
    Blackjack public game;
    ChipToken public token;

    function joinGame(Blackjack _game, ChipToken _token) external {
        game = _game;
        token = _token;
    }

    function bet(uint256 amount) external {
        _approve(amount);
        game.bet(amount);
    }

    function _approve(uint256 amount) internal {
        token.approve(address(game), amount);
    }
}
