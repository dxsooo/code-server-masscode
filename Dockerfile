FROM --platform=linux/amd64 node:18

RUN apt-get update && apt-get install -y git

RUN npm install -g pnpm json
ENV ELECTRON_MIRROR https://cdn.npm.taobao.org/dist/electron/

RUN git clone https://github.com/massCodeIO/massCode.git

RUN cd massCode && \
    git checkout v3.7.0 && \
    sed -i "s/snap/deb/g" config/electron-builder.ts && \
    json -I -f package.json -e "this.author.email='zeohan.dxs@gmail.com'" && \
    pnpm install && \
    pnpm run build