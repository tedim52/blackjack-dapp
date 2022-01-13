#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

DEALER=$DEALER_ADDRESS
PLAYER=$PLAYER_ADDRESS
blackjack=$BLACKJACK_ADDRESS
token=$TOKEN_ADDRESS

BET_AMOUNT=$1

$(ETH_FROM=$PLAYER seth send $token 'approve(address,uint256)' $(seth --to-address $DEALER)\
  $(seth --to-uint256 $BET_AMOUNT) --gas 6000000 --rpc-url $ETH_RPC_URL)
echo "Player approved $DEALER to transfer $BET_AMOUNT tokens on their behalf."

$(ETH_FROM=$PLAYER seth send $blackjack 'bet(uint256)' $(seth --to-uint256 $BET_AMOUNT) --gas 6000000 --gas 6000000 --rpc-url $ETH_RPC_URL)
echo "Player bets $BET_AMOUNT tokens."

