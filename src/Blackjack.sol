/// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "@openzeppelin/utils/Context.sol";
import "./ChipToken.sol";
import "./CardDeck.sol";

/// @title A Blackjack game.
/// @author Tedi Mitiku
/// @dev work in progress, not tested
contract Blackjack is Context {
    /// state variables
    /// state variable attributes:
    /// Visibility for state variables: public, internal, private
    /// Mutability for state variables: constant or immutable
    uint256 public constant minBet = 1; /// TODO: correct minbet and maxBet values
    uint256 public constant maxBet = 1000000000000000000000;

    struct Player {
        bool isPlayer;
        bool betMade;
        bool playedTurn;
        uint256 betValue;
        uint256 stackValue;
    }

    enum Stage {
        BETTING,
        DEALING,
        PLAYING,
        PAYOUT,
        GAME_OVER
    }

    enum Decision {
        HIT,
        STAND
    }

    struct GameMetadata {
        address dealer;
        uint256 dealersPot;
        address currentPlayer;
        uint256 betCount;
        uint256 moveCount;
        uint256 numPlayers;
        Stage currentStage;
    }

    ChipToken public token;
    mapping(address => Player) public players;
    GameMetadata private game;
    address private factoryAddress;
    CardDeck private deck;

    // events
    event BetReceived(address player, uint256 amount);
    event StageAdvanced(Stage stage);
    event PlayerMoved(address player);
    event DealerMoved(address dealer);
    event CollectedChips(address player, uint256 amount);
    event PaidChips(address player, uint256 amount);

    // modifiers
    modifier isStage(Stage stage) {
        require(
            game.currentStage == stage,
            "function cannot be called right now"
        );
        _;
    }

    modifier isValidBet(uint256 amount) {
        require(
            amount <= maxBet && amount >= minBet,
            "bet amount must be valid."
        );
        require(
            players[_msgSender()].isPlayer == true,
            "not a player in this game."
        );
        require(
            players[_msgSender()].betMade == false,
            "player has already bet"
        );
        require(
            token.balanceOf(_msgSender()) > amount,
            "player doesn't have enough tokens"
        );
        _;
    }

    modifier onlyDealer() {
        require(
            _msgSender() == game.dealer,
            "only the dealer can call this function"
        );
        _;
    }

    /// constructor
    constructor(address[] memory _players, address _token) {
        token = ChipToken(_token);
        factoryAddress = _msgSender(); // this is implying that the "_msgSender()" should always be a BlackjackFactory, how do we enforce this requirement?
        for (uint256 i = 0; i < _players.length; i++) {
            address player = _players[i];
            players[player] = Player(true, false, false, 0, 0);
        }
        game = GameMetadata(
            address(this),
            0,
            _players[0],
            0,
            0,
            _players.length,
            Stage.BETTING
        );
        /// deck = createDeck();
    }

    /// Function attributes:
    /// Visibility for functions: external, public, internal, private
    /// Mutability for functions: view, pure
    /// Modifiers for functions: virtual, override, or custom(think about what modifers each one needs)
    /// returns

    /// external functions - only accessed externally, never internally
    function bet(uint256 amount)
        external
        isStage(Stage.BETTING)
        isValidBet(amount)
    {
        address player = _msgSender();

        _collect_chips(player, amount);

        players[player].betMade = true;
        players[player].betValue = amount;
        game.betCount++;

        emit BetReceived(player, amount);

        if (_is_betting_over()) {
            _advance_stage();
        }
    }

    function deal() external isStage(Stage.DEALING) onlyDealer {}

    function play(Decision decision) external isStage(Stage.PLAYING) {}

    function playDealer() external onlyDealer isStage(Stage.PLAYING) {}

    function payout() external onlyDealer {}

    function getPlayerInfo(address player)
        external
        view
        returns (
            bool,
            bool,
            uint256,
            uint256
        )
    {
        return (
            players[player].betMade,
            players[player].playedTurn,
            players[player].betValue,
            players[player].stackValue
        );
    }

    function getCurrentStage() external view returns (Stage) {
        return game.currentStage;
    }

    /// public functions - can be accessed externally and internally

    /// internal functions - only accessed internally and by derived functions

    /// private functions - only accessed by this function
    function _collect_chips(address player, uint256 amount) internal {
        token.transferFrom(player, game.dealer, amount);
    }

    function _advance_stage() internal {
        if (game.currentStage == Stage.BETTING) {
            game.currentStage == Stage.DEALING;
            emit StageAdvanced(Stage.DEALING);
        } else if (game.currentStage == Stage.DEALING) {
            game.currentStage == Stage.PLAYING;
            emit StageAdvanced(Stage.PLAYING);
        } else if (game.currentStage == Stage.PLAYING) {
            game.currentStage == Stage.PAYOUT;
            emit StageAdvanced(Stage.PAYOUT);
        } else if (game.currentStage == Stage.PAYOUT) {
            game.currentStage == Stage.GAME_OVER;
            emit StageAdvanced(Stage.GAME_OVER);
        } else {}
    }

    function _is_betting_over() internal view returns (bool) {
        return game.betCount == game.numPlayers;
    }

    function _is_playing_over() internal view returns (bool) {
        return game.moveCount == game.numPlayers;
    }

    function _is_payout_over() internal returns (bool) {}

    function _is_game_over() internal returns (bool) {}
}
