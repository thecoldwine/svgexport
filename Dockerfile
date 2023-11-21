FROM node:20.9-bookworm-slim

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN apt-get update && \
    apt-get install -y wget gnupg && \
    apt-get install -y fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
        libgtk2.0-0 libnss3 libatk-bridge2.0-0 libdrm2 libxkbcommon0 libgbm1 libasound2 && \
    apt-get install -y chromium && \
    apt-get clean

RUN mkdir -p /app

WORKDIR /app

COPY package-lock.json package.json /app/

RUN npm ci

COPY . /app

RUN chown -R nobody:nogroup /app

USER nobody

ENTRYPOINT [ "node", "bin/index.js" ]