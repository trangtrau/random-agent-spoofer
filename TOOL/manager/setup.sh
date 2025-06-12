#!/bin/bash

# Khai báo biến
BINARY_URL="https://github.com/trangtrau/random-agent-spoofer/raw/refs/heads/master/TOOL/manager/main"
DESTINATION="/home/main"
SERVICE_NAME="random-agent-manager"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "[✔] Service '$SERVICE_NAME' is already running."
    exit 0
fi
# Cập nhật hệ thống và cài Docker
sudo apt update
sudo apt install docker.io -y



# Kiểm tra service đã tồn tại và đang chạy chưa
if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "[✔] Service '$SERVICE_NAME' is already running."
    exit 0
fi

echo "[!] Service '$SERVICE_NAME' is not running. Tiến hành cài đặt..."

# Tải binary
echo "[+] Downloading binary..."
curl -L "$BINARY_URL" -o "$DESTINATION"

# Cấp quyền thực thi
chmod +x "$DESTINATION"
echo "[+] Binary saved and made executable at $DESTINATION"

# Tạo service file
cat <<EOF | sudo tee "$SERVICE_FILE" > /dev/null
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

# Reload systemd và khởi động service
echo "[+] Enabling and starting service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now "$SERVICE_NAME"

# Kiểm tra lại trạng thái
if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "[✔] Service '$SERVICE_NAME' is now running."
else
    echo "[✖] Failed to start service '$SERVICE_NAME'."
fi
