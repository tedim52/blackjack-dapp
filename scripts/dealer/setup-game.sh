#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

DEALER=$DEALER_ADDRESS
PLAYER=$PLAYER_ADDRESS
token=$TOKEN_ADDRESS

$(ETH_FROM=$DEALER seth send $token 'mint(address,uint256)' $(seth --to-address $DEALER)\
  $(seth --to-uint256 100000000000) --gas 600000 --rpc-url $ETH_RPC_URL)
echo "Minted tokens for $DEALER"

$(ETH_FROM=$DEALER seth send $token 'mint(address,uint256)' $(seth --to-address $PLAYER)\
  $(seth --to-uint256 1000000000000000000) --gas 600000 --rpc-url $ETH_RPC_URL)
echo "Minted tokens for Player: $PLAYER"

sh ./scripts/dealer/deploy-blackjack.sh