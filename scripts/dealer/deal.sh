#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

DEALER=$DEALER_ADDRESS
blackjack=$BLACKJACK_ADDRESS


$(ETH_FROM=$DEALER seth send $blackjack 'deal()' --gas 6000000 --rpc-url $ETH_RPC_URL)
echo "Dealer deals cards."