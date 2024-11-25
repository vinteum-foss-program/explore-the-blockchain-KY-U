# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

transaction=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 2)

txinwitness=$(echo "$transaction" | jq -r '.vin[0] | .txinwitness')
#Elements of twinwitness:
#The first element: Signature used to sign the input.
#The second element: Flag.
#The third element: Redeem script or Public key.

# Extract signature
signature=$(echo "$txinwitness" | jq -r '.[0]')
# Extract pubkey script
public_key_script=$(echo "$txinwitness" | jq -r '.[2]')

#Public keys start with 02, 03(compressed, 33 bytes) or 04(uncompressed 65 bytes)
# Decode public keys
public_keys=$(echo "$public_key_script" | jq -Rr 'scan("02[0-9a-f]{64}|03[0-9a-f]{64}|04[0-9a-f]{128}")')
#echo "$public_key_script" | jq -Rr 'scan("02[0-9a-f]{64}|03[0-9a-f]{64}|04[0-9a-f]{128}")'
echo -n "$public_keys" | head -n 1
#echo $public_keys
#echo $public_keys | jq -r '.[0]'
