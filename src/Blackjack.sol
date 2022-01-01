/// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "./ChipToken.sol";
import "./CardDeck.sol";

/// @title A Blackjack game.
/// @author Tedi Mitiku
/// @dev work in progress, not tested
contract Blackjack {
    /// state variables
    /// State variable attributes:
    /// Visibility for state variables: public, internal, private
    /// Mutability for state variables: constant or immutable
    uint256 public constant minBet = 10000; // correct minBet and maxBet values
    uint256 public constant maxBet = 10000000000;

    ChipToken public token; // for now ignore access rules, let anybody transfer money

    // consider adding a struct to track Game metadata? time, dealer, etc.

    address payable public dealer;

    uint256 private dealersPot;
    address private factoryAddress;

    CardDeck private deck;

    enum Decision {
        HIT,
        STAND
    }

    address private currentPlayer;

    struct Player {
        address payable playerAddress;
        bool playedTurn;
        bool betMade;
        uint256 betValue;
        uint256 stackValue;
    }
    mapping(address => Player) players;

    /// constructor
    constructor(
        address[] memory _players,
        address _factoryAddress,
        address _token
    ) {
        token = ChipToken(_token);
        dealer = payable(msg.sender);
        dealersPot = 0;
        factoryAddress = _factoryAddress;
        for (uint256 i = 0; i < _players.length; i++) {
            address playerAddress = _players[i];
            players[playerAddress] = Player(
                payable(playerAddress),
                false,
                false,
                0,
                0
            );
        }
        /// deck = createDeck();
    }

    /// Function attributes:
    /// Visibility for functions: external, public, internal, private
    /// Mutability for functions: view, pure
    /// Modifiers for functions: virtual, override, or custom(think about what modifers each one needs)
    /// returns

    /// external functions - only accessed externally, never internally

    /// @notice
    /// @param
    function bet(address player, uint256 amount) external {
        /// require that the value of the bet is greater than minBet and less than maxBet
        /// require that this player has not already bet
        /// require that this address is a player
        /// check that this player has enough tokens for this transfer
        /// transfer money from the player to this dealer
        /// thus the dealer must have AccessControl to do that
        /// if everything works well, update that players Bet amount
    }

    /// @notice
    /// @param
    function deal() external {} /// modifer: onlyOwner() or admin or whatever

    /// @notice
    /// @param
    function playerTurn(Decision decision) external {}

    /// @notice
    /// @param
    function dealerTurn() external {} /// modifer: onlyOwner() or admin or whatever

    /// public functions - can be accessed externally and internally

    /// internal functions - only accessed internally and by derived functions

    /// private functions - only accessed by this function
}
