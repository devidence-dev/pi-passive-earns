# Multi-stage build for different architectures
ARG TARGETARCH

FROM debian:13.2-slim AS base

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    tar \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Download and install GaGaNode apphub for amd64
FROM base AS amd64-build
RUN curl -o apphub-linux-amd64.tar.gz https://assets.coreservice.io/public/package/60/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz && \
    tar -zxf apphub-linux-amd64.tar.gz && \
    rm -f apphub-linux-amd64.tar.gz && \
    cp -r apphub-linux-amd64/* . && \
    chmod +x apphub

# Download and install GaGaNode apphub for arm64
FROM base AS arm64-build
RUN curl -o apphub-linux-arm64.tar.gz https://assets.coreservice.io/public/package/61/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz && \
    tar -zxf apphub-linux-arm64.tar.gz && \
    rm -f apphub-linux-arm64.tar.gz && \
    cp -r apphub-linux-arm64/* . && \
    chmod +x apphub

FROM ${TARGETARCH}-build AS final

# Copy startup script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
