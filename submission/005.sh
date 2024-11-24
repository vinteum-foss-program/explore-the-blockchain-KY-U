# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
rawtransaction=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517)
#echo $rawtransaction
decoded_transaction=$(bitcoin-cli decoderawtransaction $rawtransaction)
#echo $decoded_transaction
input_pubkeys=$(echo $decoded_transaction | jq -r '[.vin[].txinwitness[1]]') 
bitcoin-cli createmultisig 1 "$input_pubkeys" | jq -r '.address'