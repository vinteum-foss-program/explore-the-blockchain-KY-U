# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

#descriptor format
#purpose="86h" #endereço taproot
#coin_type="0h"
#account="0h" #?
#change="0" #endereço de recebimento
#index=100
xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

#Getting the checksum
basic_descriptor="tr($xpub/*)"
checksum=$(bitcoin-cli getdescriptorinfo "$basic_descriptor" | jq -r .checksum)

#Getting the taproot address derived at index 100
#descriptor="tr([$checksum/$purpose/$coin_type/$account/$change/$index]$xpub)"
descriptor="tr($xpub/*)#$checksum"
taproot_address=$(bitcoin-cli deriveaddresses "$descriptor" "[100,100]" | jq -r '.[0]')
echo -n "$taproot_address"

