FROM ubuntu:22.04

WORKDIR /root/

RUN apt-get update && apt-get install -y curl unzip

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g pnpm

# get source code
ARG MASSCODE_VERSION=v3.7.0

RUN curl -fsSL https://github.com/massCodeIO/massCode/archive/refs/tags/${MASSCODE_VERSION}.zip > masscode-src.zip \
    && unzip masscode-src.zip \
    && rm masscode-src.zip

# build
RUN cd massCode-* && pnpm install

