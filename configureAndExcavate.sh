#! /bin/bash

if [ -z ${WORKERNAME+x} ]; then
        WORKERNAME=$HOSTNAME
fi
echo "WALLET: $WALLET"
echo "WORKERNAME: $WORKERNAME"

# Detect available GPUs
GPUCOUNT=`nvidia-smi --query-gpu=gpu_name --format=csv | wc -l`
GPUCOUNT=$((GPUCOUNT-1))
echo "GPU COUNT: $GPUCOUNT"

# Prepare configuration so that all GPUs are being used
WORKERS=`echo -e "\t{\"id\":1,\"method\":\"worker.add\",\"params\":[\"0\",\"0\"]}"`
PRINTS=`echo -e "{\"id\":1,\"method\":\"worker.print.speed\",\"params\":[\"0\"]}"`
for (( idx = 1 ; idx < $GPUCOUNT ; idx++ ))
do
        id=$((idx+1))
        WORKERS="$WORKERS, {\"id\":$id,\"method\":\"worker.add\",\"params\":[\"0\",\"$idx\"]}"
        PRINTS="$PRINTS, {\"id\":$id,\"method\":\"worker.print.speed\",\"params\":[\"$idx\"]}"
done
sed -e "s/\${wallet}/$WALLET/" -e "s/\${workername}/$WORKERNAME/" -e "s/\${workers}/$WORKERS/" -e "s/\${prints}/$PRINTS/" /excavator.config > /excavator.inst.config

excavator -c /excavator.inst.config