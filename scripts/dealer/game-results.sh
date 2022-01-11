#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

DEALER=$ETH_FROM
PLAYER=$PLAYER_ADDRESS
blackjack=$BLACKJACK_ADDRESS
token=$TOKEN_ADDRESS

seth send $blackjack 'payout()' --gas 6000000 --rpc-url $ETH_RPC_URL

BALANCE=$(seth call $token 'balanceOf(address)' $(seth --to-address $PLAYER)\
           --gas 60000000 --rpc-url $ETH_RPC_URL)

echo "Player ends with a balance of: $BALANCE."
