ETH_RPC_URL=https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}

token=0x1255b1D9D581707292F5cC36ad48eeb5A4fD19CF

ADDRESS=$(ETH_FROM=$ETH_FROM dapp create Blackjack "[$(seth --to-address $1)]" \
          $(seth --to-address $token) -- --gas 6000000 --rpc-url $ETH_RPC_URL)
echo "Blackjack Round deployed at: $ADDRESS"