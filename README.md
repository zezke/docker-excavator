# docker-excavator

Docker image for running NiceHash's Excavator. It makes use of [nuxhash](https://github.com/YoRyan/nuxhash) to ensure that the most profitable algorithm is running.

## Usage

You can use the `WALLET`, `REGION` and `WORKERNAME` environment variables to configure which wallet to mine to, what NiceHash region to use and to set the worker name that will be passed along.

`docker run --runtime=nvidia --restart unless-stopped -d -e WALLET='3KAKffgMS6JzNA5oa6C19zGXJgQbZxSFo6' -e WORKERNAME=worker1 -e REGION=eu zezke/excavator`

If you want to limit the container to use only a subset of the available GPUs on your machine you can make use of the `NVIDIA_VISIBLE_DEVICES` environment variable by [nvidia-docker2](https://github.com/NVIDIA/nvidia-docker/wiki/Usage).

`docker run --runtime=nvidia --restart unless-stopped -d -e WALLET='3KAKffgMS6JzNA5oa6C19zGXJgQbZxSFo6' -e WORKERNAME=worker1 -e REGION=eu -e NVIDIA_VISIBLE_DEVICES=0 zezke/excavator`

## Benchmarks

Before starting the actual mining, a series of benchmarks will be run. This is required to get reliable profitability calculations. If you want to skip this, or reuse previous benchmarks, it is best to mount a volume to the `/nuxhash-config/` directory. Nuxhash writes both the config file (`settings.conf`) and the benchmark results to this directory (`benchmarks.json`).

`docker run --runtime=nvidia --restart unless-stopped -d -v ~/nuxhash-config:/nuxhash-config -e WALLET='3KAKffgMS6JzNA5oa6C19zGXJgQbZxSFo6' -e WORKERNAME=worker1 -e REGION=eu zezke/excavator`

You can find an example `benchmarks.json` file below from a server with a single Nvidia GTX 1080 GPU.

`{
    "nvidia_0": {
        "excavator_lyra2rev2": 43554668.00944128,
        "excavator_daggerhashimoto_decred": [
            19208185.67716676,
            1536655459.5660486
        ],
        "excavator_decred": 3145460079.2091618,
        "excavator_equihash": 496.25096678299553,
        "excavator_pascal": 1157547266.6772702,
        "excavator_daggerhashimoto_pascal": [
            19134026.437333327,
            673517639.8479613
        ],
        "excavator_daggerhashimoto": 19435341.269781634,
        "excavator_daggerhashimoto_sia": [
            18995013.790986173,
            1013071565.8073746
        ],
        "excavator_lbry": 305086431.7361219,
        "excavator_nist5": 52305897.175597735,
        "excavator_keccak": 885807231.9303339,
        "excavator_neoscrypt": 1077331.9076695147,
        "excavator_cryptonight": 407.1806582499811,
        "excavator_blake2s": 0.0,
        "excavator_sia": 1960135393.0411048
    }
}`