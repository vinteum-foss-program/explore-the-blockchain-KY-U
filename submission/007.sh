# Only one single output remains unspent from block 123,321. What address was it sent to?

hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash 2)

#Cria os comandos a serem rodados
echo "$block" | jq -r '.tx[] | .txid as $txid | .vout[] | "bitcoin-cli gettxout \($txid) \(.n) | jq -r \".scriptPubKey.address\""' | while read -r cmd; do
  result=$(eval "$cmd") # Executa o comando e armazena o resultado
  if [[ -n "$result" ]]; then # Verifica se o resultado não é nulo
    echo -n $result
    break # Encerra o loop
  fi
done

#nem isso funciona, que tristeza
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