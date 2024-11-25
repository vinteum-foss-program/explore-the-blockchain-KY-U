# Which tx in block 257,343 spends the coinbase output of block 256,128?

#Block 256,128
hash=$(bitcoin-cli getblockhash 256128)
block=$(bitcoin-cli getblock $hash)
coinbase=$(echo "$block" | jq -r '.tx[0]')
#echo "A COINBASE QUE ESTAMOS PROCURANDO EH:"
#echo $coinbase

#Desnecessário
#coinbase_output=$(bitcoin-cli getrawtransaction "$coinbase" true "$hash" | jq -r '.vout[].scriptPubKey.address') 

#Block 257,343
hash=$(bitcoin-cli getblockhash 257343)
block=$(bitcoin-cli getblock $hash 2)
echo "$block" | jq -r --arg coinbase "$coinbase" '.tx[] | select(.vin[]?.txid == $coinbase) | .txid'

#coinbase=$(echo "$coinbase" | tr -d '\n')
#echo "LISTA DE TX:"
#for tx in $(echo "$block" | jq -r '.tx[].vin[].txid?'); do
#  tx=$(echo "$tx" | tr -d '\n')
#  if [[ "$tx" == "$coinbase" ]]; then
#    echo "$block" | jq -r --arg txid "$tx" '.tx[] | select(.vin[].txid == $txid) | .txid'
#    echo "ACHEI"
#    break
#  fi

#Visualizar tudo imprimido
#  echo "$tx"
#done