FROM nvidia/cuda:8.0-runtime-ubuntu16.04

# Install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ocl-icd-opencl-dev

ADD https://github.com/nicehash/excavator/releases/download/v1.3.9a/excavator_1.3.9a-xenial0_amd64.deb /excavator_1.3.9a-xenial0_amd64.deb
RUN apt install ./excavator_1.3.9a-xenial0_amd64.deb

COPY excavator.config /
COPY configureAndExcavate.sh /
RUN chmod +x /configureAndExcavate.sh

ARG WALLET=3KAKffgMS6JzNA5oa6C19zGXJgQbZxSFo6
ENV WALLET $WALLET
ENTRYPOINT /configureAndExcavate.sh