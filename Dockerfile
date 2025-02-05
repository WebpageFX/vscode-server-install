FROM alpine:latest

# https://github.com/microsoft/vscode/releases

# v1.95.3
# ARG VSCODE_SERVER_COMMIT=f1a4fb101478ce6ec82fe9627c43efbf9e98c813

# v1.96.0
ARG VSCODE_SERVER_COMMIT=138f619c86f1199955d53b4166bef66ef252935c

# ..etc

# Install required dependencies
RUN apk add --no-cache curl tar

# Download and extract VS Code server in one step, avoiding temporary file
RUN mkdir -p ~/.vscode-server/cli/servers/Stable-${VSCODE_SERVER_COMMIT}/server && \
    curl -fsSL https://update.code.visualstudio.com/commit:${VSCODE_SERVER_COMMIT}/server-linux-x64/stable | \
    tar -xz -C ~/.vscode-server/cli/servers/Stable-${VSCODE_SERVER_COMMIT}/server