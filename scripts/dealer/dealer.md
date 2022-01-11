To simulate a one player blackjack round, the dealer should execute scripts in this order:

(go to base directory)

./scripts/dealer/setup-game.sh (address of player) (address of token)

(player makes their bet)

./scripts/dealer/deal.sh

(player plays their turns)

./scripts/dealer/game-results.sh
