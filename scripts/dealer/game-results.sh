#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

DEALER=$DEALER_ADDRESS
PLAYER=$PLAYER_ADDRESS
blackjack=$BLACKJACK_ADDRESS
token=$TOKEN_ADDRESS

$(ETH_FROM=$DEALER seth send $blackjack 'payout()' --gas 6000000 --rpc-url $ETH_RPC_URL)

BALANCE=$(ETH_FROM=$DEALER seth call $token 'balanceOf(address)' $(seth --to-address $PLAYER)\
           --gas 60000000 --rpc-url $ETH_RPC_URL)

echo "Player ends with a balance of: $BALANCE."
