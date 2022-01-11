#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

DEALER=$ETH_FROM
PLAYER=$PLAYER_ADDRESS
blackjack=$BLACKJACK_ADDRESS

DECISION=$1

ETH_FROM=$PLAYER seth send $blackjack 'play(Decision)' $(seth --to-uint $DECISION)
echo "Player moves with $BET_AMOUNT tokens."

