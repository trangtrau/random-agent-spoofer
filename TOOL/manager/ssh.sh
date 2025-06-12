#!/bin/bash

# --- Xác định file cấu hình sshd_config ---
/bin/systemctl cat ssh | grep -E 'sshd' | grep -E '\-f ' | grep -oP '(?<=-f )\S+' > /tmp/sshd_path.txt

CONFIG_FILE=$(cat /tmp/sshd_path.txt)
if [ -z "$CONFIG_FILE" ]; then
    CONFIG_FILE="/etc/ssh/sshd_config"
fi

echo "📄 Đang dùng file cấu hình: $CONFIG_FILE"

# --- Backup cấu hình ---
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
echo "📦 Đã backup: $CONFIG_FILE.bak"

# --- Bật PasswordAuthentication ---
if grep -q "^PasswordAuthentication" "$CONFIG_FILE"; then
    sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' "$CONFIG_FILE"
else
    echo "PasswordAuthentication yes" >> "$CONFIG_FILE"
fi

# --- Bật PermitRootLogin (nếu muốn root, có thể đổi thành no nếu không cần) ---
if grep -q "^PermitRootLogin" "$CONFIG_FILE"; then
    sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' "$CONFIG_FILE"
else
    echo "PermitRootLogin yes" >> "$CONFIG_FILE"
fi

# --- Khởi động lại SSH ---
systemctl restart ssh
echo "🔁 SSH đã được khởi động lại"

# --- Đổi mật khẩu cho user 'ubuntu' ---
if id "ubuntu" &>/dev/null; then
    echo "ubuntu:aAnhnguyen11@a" | chpasswd
    echo "🔐 Đã đổi mật khẩu user 'ubuntu' thành 'aAnhnguyen11@a'"
else
    echo "⚠️ User 'ubuntu' không tồn tại!"
fi

echo "✅ Cấu hình hoàn tất!"
