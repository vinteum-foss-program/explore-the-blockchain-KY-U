# How many new outputs were created by block 123,456?

#Get block information
hash=$(bitcoin-cli getblockhash 123456)
block=$(bitcoin-cli getblock $hash 2) # 2 is verbose option

#Sums the lenght of every vout array of every transaction
echo $block | jq '[.tx[].vout | length] | add'