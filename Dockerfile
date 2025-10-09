# Use the official n8n image as the base
FROM docker.n8n.io/n8nio/n8n:latest

# Switch to root to install system packages
USER root

# Install Chromium + required libraries for Puppeteer
RUN apt-get update && \
    apt-get install -y chromium fonts-liberation libatk-bridge2.0-0 \
    libatk1.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxfixes3 libxrandr2 libgbm1 libasound2 libpango1.0-0 libpangocairo-1.0-0 \
    libx11-xcb1 libnss3 libxss1 libxtst6 xvfb && \
    rm -rf /var/lib/apt/lists/*

# Install Puppeteer globally (without downloading Chromium again)
RUN npm install -g puppeteer && \
    PUPPETEER_SKIP_DOWNLOAD=true npm install puppeteer

# Tell Puppeteer where Chromium is
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Switch back to node user
USER node
