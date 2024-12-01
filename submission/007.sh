# Only one single output remains unspent from block 123,321. What address was it sent to?

#Get information about block 123321
hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash 2)

#For each output of every transaction, generates a command to retrieve the unspent output information.
echo "$block" | jq -r '.tx[] | .txid as $txid | .vout[] | "bitcoin-cli gettxout \($txid) \(.n) | jq -r \".scriptPubKey.address\""' | while read -r cmd; do
  result=$(eval "$cmd") 
  if [[ -n "$result" ]]; then #Stops when the address is found
    echo -n $result
    break 
  fi
done

#Does not work
#for tx in $(echo "$block" | jq -r '.tx[].txid'); do
#  tx=$(echo "$tx" | tr -d '\n')
#  txout=$(bitcoin-cli gettxout "$tx" 0)
#  echo $txout
#done

#for tx in $(echo "$block" | jq -r '.tx[].txid'); do
#  for vout_index in $(echo "$block" | jq -r --arg tx "$tx" '.tx[] | select(.txid == $tx) | .vout[].n'); do
#    txout=$(bitcoin-cli gettxout "$tx" $vout_index)
#    echo $txout
#    if [ "$txout" != "null" ]; then
#       echo "$txout" | jq -r '.scriptPubKey.address'
#      break
#    fi
#  done
#done