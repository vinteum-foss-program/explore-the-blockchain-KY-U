# Which tx in block 257,343 spends the coinbase output of block 256,128?

#Gets information about block 256,128
hash=$(bitcoin-cli getblockhash 256128)
block=$(bitcoin-cli getblock $hash)

#The coinbase is the first transaction of a block
coinbase=$(echo "$block" | jq -r '.tx[0]')

#Gets information about block 257,343
hash=$(bitcoin-cli getblockhash 257343)
block=$(bitcoin-cli getblock $hash 2)

#Looks, for every input (vin) of every transaction in the block, every transaction iD (txid) that matches the coinbase
echo "$block" | jq -r --arg coinbase "$coinbase" '.tx[] | select(.vin[]?.txid == $coinbase) | .txid'

#For some reason, this script does not works :(
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