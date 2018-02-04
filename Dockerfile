FROM node:9.5.0-alpine

# Create /app dir where files can be read/written
ENV \
    APP_DIRECTORY=/app \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Installs Chromium
RUN set -ex \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && apk update \
    && apk add --upgrade apk-tools@edge \
    && apk upgrade \
    && apk add --no-cache \
        chromium@edge \
        nss@edge \
    && rm -rf /tmp/* /var/cache/apk/*

# Puppeteer v0.11.0 works with Chromium 63.
RUN yarn add puppeteer@0.11.0 mermaid.cli@0.3.1

# Copying modified Mermaid CLI script and Build script
RUN sed -i "63s#puppeteer.launch()#puppeteer.launch({args: ['--no-sandbox', '--disable-setuid-sandbox'], executablePath: '/usr/bin/chromium-browser'})#g" \
    /node_modules/mermaid.cli/index.bundle.js
COPY scripts/build.sh /build.sh

# Create app directory
RUN mkdir -p ${APP_DIRECTORY}

CMD ["sh", "/build.sh"]
