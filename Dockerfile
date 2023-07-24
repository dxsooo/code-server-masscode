FROM ubuntu:22.04

WORKDIR /root/

RUN apt-get update && apt-get install -y wget nodejs npm unzip
RUN npm install -g pnpm

# get source code
ARG MASSCODE_VERSION v3.7.0

RUN wget -O masscode-src.zip https://github.com/massCodeIO/massCode/archive/refs/tags/${MASSCODE_VERSION}.zip \
    && unzip masscode-src.zip

# build
RUN cd masscode-src && pnpm install

