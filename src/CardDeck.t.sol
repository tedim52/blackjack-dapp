// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test";
import "./Blackjack.sol";
import "./CardDeck.sol";
import "./ChipToken.sol";
import "./TestPlayer.sol";

contract CardDeckTest is DSTest {
    using CardDeckUtils for CardDeck;
    CardDeck deck;

    function setUp() public {
        deck.createDeck();
    }

    function test_full_deck_created() public {
        assertEq(52, deck.cards.length);
    }

    function test_draw_card_removes_card() public {
        Card memory removedCard = deck.drawCard();

        bool cardRemoved = true;
        for (uint256 i = 0; i < deck.cards.length; i++) {
            Card memory card = deck.cards[i];
            if (
                card.suit == removedCard.suit && card.value == removedCard.value
            ) {
                cardRemoved = false;
                break;
            }
        }

        assertTrue(cardRemoved);
        assertEq(51, deck.cards.length);
    }

    function testFail_when_attempting_to_remove_card_from_empty_deck() public {
        for (uint256 i = 0; i < 52; i++) {
            deck.drawCard();
        }

        deck.drawCard();
    }
}
