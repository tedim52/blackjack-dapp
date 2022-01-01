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

    address public dealer;

    uint256 private dealersPot;
    address private factoryAddress;

    CardDeck private deck;

    enum Stage {
        BETTING,
        PLAYER_TURN,
        DEALER_TURN,
        PAYOUT
    }
    enum Decision {
        HIT,
        STAND
    }
    Stage public currentStage;
    address private currentPlayer;

    struct Player {
        address playerAddress;
        bool betMade;
        bool playedTurn;
        uint256 betValue;
        uint256 stackValue;
    }
    mapping(address => Player) public players;

    // events
    event BetMade(address player, uint256 amount);

    /// constructor
    constructor(
        address[] memory _players,
        address _factoryAddress,
        address _token
    ) {
        token = ChipToken(_token);
        dealer = msg.sender;
        dealersPot = 0;
        factoryAddress = _factoryAddress;
        currentStage = Stage.BETTING;
        for (uint256 i = 0; i < _players.length; i++) {
            address playerAddress = _players[i];
            players[playerAddress] = Player(playerAddress, false, false, 0, 0);
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
        // consider adding validBet function modifier to encapsulate this code
        require(
            currentStage == Stage.BETTING,
            "function can't be called right now"
        );
        require(
            amount <= maxBet && amount >= minBet,
            "bet amount must be valid."
        );
        require(
            players[player].playerAddress != address(0x0),
            "not a player in this round."
        );
        require(players[player].betMade == false, "player has already bet");
        require(
            token.balanceOf(player) > amount,
            "player doesn't have enough tokens"
        );

        // need to add access control to transferFrom
        // only dealer(with transfer role) should be able to call this
        token.transferFrom(player, dealer, amount); // consider encapsulating this into an internal function

        players[player].betMade = true;
        players[player].betValue = amount;

        emit BetMade(player, amount);
        // add a hook to check if its time to move on to the next stage
        // (when all players have bet) <-- is it expensive to check this everytime a bet is made tho
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

    /// @notice Returns player information.
    /// @param player addressmof player to receive information on.
    function getPlayer(address player)
        external
        view
        returns (
            address,
            bool,
            bool,
            uint256,
            uint256
        )
    {
        return (
            players[player].playerAddress,
            players[player].betMade,
            players[player].playedTurn,
            players[player].betValue,
            players[player].stackValue
        );
    }
    /// public functions - can be accessed externally and internally

    /// internal functions - only accessed internally and by derived functions

    /// private functions - only accessed by this function
}
