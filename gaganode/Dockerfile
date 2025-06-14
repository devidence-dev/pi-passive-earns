FROM arm64v8/debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Download and install GaGaNode apphub for ARM64
RUN curl -o apphub-linux-arm64.tar.gz https://assets.coreservice.io/public/package/61/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz && \
    tar -zxf apphub-linux-arm64.tar.gz && \
    rm -f apphub-linux-arm64.tar.gz && \
    ls -la && \
    cp -r apphub-linux-arm64/* . && \
    chmod +x apphub

# Create startup script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose any necessary ports (if needed)
# EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
