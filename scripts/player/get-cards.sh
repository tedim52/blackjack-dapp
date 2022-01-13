#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

PLAYER=$PLAYER_ADDRESS
blackjack=$BLACKJACK_ADDRESS

INFO=$(ETH_FROM=$PLAYER seth call $blackjack 'getPlayerInfo()')
echo "Player stats: $INFO"

DEALER_CARD=$(ETH_FROM=$PLAYER seth call $blackjack 'getDealerInfo()')
echo "Dealers face up card bets $DEALER_CARD tokens."

