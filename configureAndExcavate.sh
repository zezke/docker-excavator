#!/bin/sh

if [ -z ${WORKERNAME+x} ]; then
        WORKERNAME=$HOSTNAME
fi
echo "WALLET: $WALLET"
echo "WORKERNAME: $WORKERNAME"

sed -e "s/\${wallet}/$WALLET/" -e "s/\${workername}/$WORKERNAME/" /excavator.config > /excavator.inst.config

excavator -c /excavator.inst.config