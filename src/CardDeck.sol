// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

// card deck data structure
struct Card {
    uint256 value;
}

struct CardDeck {
    Card[] cards;
}

library CardDeckUtils {
    // a library of deck operations
    //  - drawCard()
    //  - createDeck()
}
