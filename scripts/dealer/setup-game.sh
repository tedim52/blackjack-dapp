#!/bin/bash

# Sets up a simulated Blackjack round with one player
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}
DEALER=$ETH_FROM
PLAYER=$1
token=$2

seth send $token 'mint(address,uint256)' $(seth --to-address $DEALER)\
  $(seth --to-uint256 100000000000) --gas 600000 --rpc-url $ETH_RPC_URL
echo "Minted tokens for $DEALER"

seth send $token 'mint(address,uint256)' $(seth --to-address $PLAYER)\
  $(seth --to-uint256 100000) --gas 600000 --rpc-url $ETH_RPC_URL
echo "Minted tokens for Player: $PLAYER"

export TOKEN_ADDRESS=$token
export PLAYER_ADDRESS=$PLAYER

sh ./scripts/dealer/deploy-blackjack.sh