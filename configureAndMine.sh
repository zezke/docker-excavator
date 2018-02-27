#!/bin/bash

if [ -z ${WORKERNAME+x} ]; then
        WORKERNAME=$HOSTNAME
fi

echo "WALLET: $WALLET"
echo "WORKERNAME: $WORKERNAME"
echo "REGION: $REGION"

# Create config file if it does not yet exist
CONFIG_FILE=/nuxhash-config/settings.conf
cat > $CONFIG_FILE <<EOL
[switching]
threshold = 0.1
interval = 60

[excavator]
path = /opt/excavator/bin/excavator
enabled = True
port = 3456

[nicehash]
wallet = $WALLET
region = $REGION
workername = $WORKERNAME
EOL

# Check if a benchmarks file was provided, if not run benchmarks
BENCHMARK_FILE=/nuxhash-config/benchmarks.json
if [ ! -f "$BENCHMARK_FILE" ]; then
        /nuxhash/nuxhashd.py --benchmark-all -c /nuxhash-config/
fi

# Start mining
/nuxhash/nuxhashd.py --show-mining -c /nuxhash-config/