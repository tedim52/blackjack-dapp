To simulate a one player round of blackjack, the player should execute scripts in this order:

(go to base directory)

(dealer sets up the game)

./scripts/player/bet.sh (bet amount)

(dealer deals cards)

./scripts/player/play.sh (decision - 0 to HIT or 1 to STAND)

(dealer finishes the game and returns players balance)
