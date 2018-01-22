FROM nvidia/cuda:9.1-base-ubuntu16.04

# Install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ocl-icd-opencl-dev

ADD https://github.com/nicehash/excavator/releases/download/v1.3.9a/excavator_1.3.9a-xenial0_amd64.deb /excavator_1.3.9a-xenial0_amd64.deb
RUN apt install ./excavator_1.3.9a-xenial0_amd64.deb

COPY excavator.config /

ENTRYPOINT excavator -c /excavator.config