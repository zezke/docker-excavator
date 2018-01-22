# docker-excavator

Docker image for running NiceHash's Excavator

## Usage

`docker run --runtime=nvidia -d -e WALLET='3KAKffgMS6JzNA5oa6C19zGXJgQbZxSFo6' zezke/excavator`

If you want to limit the container to use only a subset of the available GPUs on your machine you can make use of the `NVIDIA_VISIBLE_DEVICES` environment variable by [nvidia-docker2](https://github.com/NVIDIA/nvidia-docker/wiki/Usage).

`docker run --runtime=nvidia -d -e WALLET='3KAKffgMS6JzNA5oa6C19zGXJgQbZxSFo6' -e NVIDIA_VISIBLE_DEVICES=0 zezke/excavator`