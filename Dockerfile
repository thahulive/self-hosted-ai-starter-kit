# Use official n8n image (Alpine-based)
FROM n8nio/n8n:latest

USER root

# Install Chromium and required dependencies
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Install Puppeteer globally but skip downloading its bundled Chromium
RUN npm install -g puppeteer && \
    PUPPETEER_SKIP_DOWNLOAD=true npm install puppeteer

# Tell Puppeteer where Chromium is located in Alpine
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Disable Chromium sandbox (required inside Docker)
ENV PUPPETEER_ARGS="--no-sandbox --disable-setuid-sandbox"

# Drop back to node user
USER node
