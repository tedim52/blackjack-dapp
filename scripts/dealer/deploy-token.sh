#!/bin/bash
ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

token=$(ETH_FROM=$ETH_FROM dapp create ChipToken -- --gas 6000000 --rpc-url $ETH_RPC_URL)
echo "New ChipToken deployed at: $token"