# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

#Get raw transaction
rawtransaction=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517)

#Decode transaction
decoded_transaction=$(bitcoin-cli decoderawtransaction $rawtransaction)

#Extract the public key from the transaction witness array of the first 4 inputs of the transaction
input_pubkeys=$(echo $decoded_transaction | jq -r '[.vin[0:4][].txinwitness[1]]') 

#Creates and shows a 1-of-4 P2SH multisig address
bitcoin-cli createmultisig 1 "$input_pubkeys" | jq -r '.address'