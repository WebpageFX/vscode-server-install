FROM alpine:latest

# https://github.com/microsoft/vscode/releases


# Install required dependencies
RUN apk add --no-cache curl tar

# Download and extract VS Code server in one step, avoiding temporary file
ARG ARCH
ARG VSCODE_SERVER_COMMIT

# Map ARCH to VSCode's architecture naming
RUN VSCODE_ARCH=$([ "$ARCH" = "amd64" ] && echo "x64" || echo "arm64") && \
    mkdir -p ~/.vscode-server/cli/servers/Stable-${VSCODE_SERVER_COMMIT}/server && \
    curl -fsSL https://update.code.visualstudio.com/commit:${VSCODE_SERVER_COMMIT}/server-linux-${VSCODE_ARCH}/stable | \
    tar -xz -C ~/.vscode-server/cli/servers/Stable-${VSCODE_SERVER_COMMIT}/server
