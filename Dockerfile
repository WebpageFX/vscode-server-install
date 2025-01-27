FROM ubuntu:jammy

# https://github.com/microsoft/vscode/releases

# v1.95.3
# ARG VSCODE_SERVER_COMMIT=f1a4fb101478ce6ec82fe9627c43efbf9e98c813

# v1.96.0
ARG VSCODE_SERVER_COMMIT=138f619c86f1199955d53b4166bef66ef252935c

# ..etc

RUN apt update && apt install -y curl

# Create directories for both VS Code and Cursor servers
RUN mkdir -p /var/www/.vscode-server/cli/servers/Stable-${VSCODE_SERVER_COMMIT}/server && \
    mkdir -p /var/www/.cursor-server/bin/${VSCODE_SERVER_COMMIT} && \
    mkdir -p /var/www/.cursor-server/data/Machine

# Download and extract VS Code server in one step, avoiding temporary file
# https://stackoverflow.com/questions/77068802/how-to-install-vscode-server-offline-on-a-server-for-vscode-version-1-82-0-or-la
RUN mkdir -p ~/.vscode-server/cli/servers/Stable-${VSCODE_SERVER_COMMIT}/server && \
    curl -fsSL https://update.code.visualstudio.com/commit:${VSCODE_SERVER_COMMIT}/server-linux-x64/stable | \
    tar -xz -C ~/.vscode-server/cli/servers/Stable-${VSCODE_SERVER_COMMIT}/server
    
# Set correct ownership and permissions
RUN chown -R www-data:www-data /var/www/.vscode-server && \
    chown -R www-data:www-data /var/www/.cursor-server && \
    chmod -R 755 /var/www/.vscode-server && \
    chmod -R 755 /var/www/.cursor-server