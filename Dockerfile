FROM --platform=linux/amd64 node:18 as build

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

FROM codercom/code-server:4.15.0-bullseye

USER root
RUN apt-get update && apt-get install -y libnotify4 libnss3 libxss1 xdg-utils libsecret-1-0 libasound2 libgbm1 xvfb

COPY --from=build /massCode/dist/masscode_3.7.0_amd64.deb /opt

RUN dpkg -i /opt/masscode_3.7.0_amd64.deb

ENV DISPLAY ':99.0'
RUN sed -i '$d' /usr/bin/entrypoint.sh
RUN echo "exec Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &" | tee -a /usr/bin/entrypoint.sh
RUN echo "exec masscode --no-sandbox > /dev/null 2>&1 &" | tee -a /usr/bin/entrypoint.sh
RUN echo 'exec dumb-init /usr/bin/code-server "$@"' | tee -a /usr/bin/entrypoint.sh

USER coder
COPY *.vsix /opt
RUN code-server --install-extension /opt/AntonReshetov.masscode-assistant-1.1.0.vsix
