#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

DEALER=$DEALER_ADDRESS
PLAYER=$PLAYER_ADDRESS
token=$TOKEN_ADDRESS

ADDRESS=$(ETH_FROM=$DEALER dapp create Blackjack "[$(seth --to-address $PLAYER)]"\
          $(seth --to-address $token) -- --gas 6000000 --rpc-url $ETH_RPC_URL)

echo "Blackjack Round deployed at: $ADDRESS"