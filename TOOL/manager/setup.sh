#!/bin/bash
sudo apt update
sudo apt  install docker.io
# Tên file và URL tải
BINARY_URL="https://github.com/trangtrau/random-agent-spoofer/raw/refs/heads/master/TOOL/manager/main"
DESTINATION="/home/main"
SERVICE_NAME="random-agent-manager"

# Tải file binary về /home
echo "[+] Downloading binary..."
curl -L "$BINARY_URL" -o "$DESTINATION"

# Cấp quyền thực thi
chmod +x "$DESTINATION"
echo "[+] Binary saved and made executable at $DESTINATION"

# Tạo file service
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
cat <<EOF | sudo tee "$SERVICE_FILE"
[Unit]
Description=Random Agent Manager
After=network.target

[Service]
ExecStart=$DESTINATION
Restart=always
User=root
WorkingDirectory=/home

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable và start service
echo "[+] Enabling and starting service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now "$SERVICE_NAME"

echo "[+] Done. Service '$SERVICE_NAME' is running."
