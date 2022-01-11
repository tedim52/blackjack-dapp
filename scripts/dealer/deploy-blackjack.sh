#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

PLAYER=$PLAYER_ADDRESS
token=$TOKEN_ADDRESS

ADDRESS=$(dapp create Blackjack "[$(seth --to-address $PLAYER)]"\
          $(seth --to-address $token) -- --gas 6000000 --rpc-url $ETH_RPC_URL)

export BLACKJACK_ADDRESS=$ADDRESS
echo "Blackjack Round deployed at: $ADDRESS"