#!/bin/bash

# --- Xác định file cấu hình sshd_config ---
/bin/systemctl cat ssh | grep -E 'sshd' | grep -E '\-f ' | grep -oP '(?<=-f )\S+' > /tmp/sshd_path.txt

CONFIG_FILE=$(cat /tmp/sshd_path.txt)
if [ -z "$CONFIG_FILE" ]; then
    CONFIG_FILE="/etc/ssh/sshd_config"
fi

echo "📄 Đang dùng file cấu hình: $CONFIG_FILE"

# --- Backup cấu hình ---
sudo cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
echo "📦 Đã backup: $CONFIG_FILE.bak"

# --- Xoá các dòng bắt đầu bằng Include ---
sudo sed -i '/^Include /d' "$CONFIG_FILE"
echo "🧹 Đã xoá các dòng bắt đầu bằng 'Include'"

# --- Bật PasswordAuthentication ---
if grep -q "^PasswordAuthentication" "$CONFIG_FILE"; then
    sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' "$CONFIG_FILE"
else
    echo "PasswordAuthentication yes" >> "$CONFIG_FILE"
fi

# --- Bật PermitRootLogin ---
if grep -q "^PermitRootLogin" "$CONFIG_FILE"; then
    sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' "$CONFIG_FILE"
else
    echo "PermitRootLogin yes" >> "$CONFIG_FILE"
fi

# --- Khởi động lại SSH ---
sudo systemctl restart ssh
echo "🔁 SSH đã được khởi động lại"

# --- Đổi mật khẩu cho user 'ubuntu' ---
# --- Xác định user hiện tại đang chạy script (qua SSH) ---
CURRENT_USER=$(whoami)

# --- Đổi mật khẩu ---
echo "$CURRENT_USER:aAnhnguyen11@a" | sudo chpasswd

echo "🔐 Đã đổi mật khẩu user '$CURRENT_USER' thành 'aAnhnguyen11@a'"


echo "✅ Cấu hình hoàn tất!"
