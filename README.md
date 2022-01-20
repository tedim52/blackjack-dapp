# Dappjack

simple blackjack app

Contracts

- Blackjack
  - represents a round of blackjack with multiple players
  - comprises majority of logic in the game
  - currently doesn't support double down or splitting pairs
- CardDeck
  - simple library for deck functionalities needed in blackjack
  - can be extended to account for future casino games
- ChipToken
  - represents casino chips
  - players can exchange money for chips to play in casino games

TODOs:

- BlackjackFactory
  - represents a table or dealer, creating multiple blackjack rounds
  - holds the pot of casino chips
- TokenSwap
  - represents "buying" into the casino to play casino games
  - allows players to exchange tokens or eth for casino chips
