#!/bin/bash
# -*- coding: utf-8 -*-
check_unicode_support

function check_unicode_support() {
    echo "🔍 Đang kiểm tra hỗ trợ Unicode trên terminal..."
    
    # Kiểm tra nếu locale của hệ thống đã được cấu hình đúng
    if ! locale | grep -q "UTF-8"; then
        echo "❌ Terminal chưa hỗ trợ Unicode. Đang cài đặt..."
        sudo apt install -y language-pack-en-base locales
        sudo locale-gen en_US.UTF-8
        sudo update-locale LANG=en_US.UTF-8
        echo "✅ Đã cài đặt hỗ trợ Unicode cho terminal."
    else
        echo "✅ Terminal đã hỗ trợ Unicode."
    fi
}

# Gọi hàm kiểm tra Unicode trước khi thực hiện các tác vụ khác




function install_lemp() {
    echo "🔧 Đang cài đặt LEMP Stack..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx mysql-server php-fpm php-mysql php-curl php-xml php-mbstring php-zip php-gd unzip wget curl certbot python3-certbot-nginx -y
    echo "✅ Đã cài đặt LEMP Stack."
}

function install_wp_site() {
    read -p "🌐 Domain: " DOMAIN
    read -p "🧩 DB Name: " DB_NAME
    read -p "👤 DB User: " DB_USER
    read -s -p "🔐 DB Password: " DB_PASS; echo
    read -p "📧 Email (để đăng ký SSL): " EMAIL

    WP_DIR="/var/www/$DOMAIN"

    # MySQL
    sudo mysql -e "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    sudo mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
    sudo mysql -e "FLUSH PRIVILEGES;"

    # WordPress
    cd /tmp
    wget https://wordpress.org/latest.tar.gz -O wordpress.tar.gz
    tar -xzf wordpress.tar.gz
    sudo mkdir -p "$WP_DIR"
    sudo cp -r wordpress/* "$WP_DIR"
    sudo chown -R www-data:www-data "$WP_DIR"
    sudo chmod -R 755 "$WP_DIR"

    # Config wp-config
    cp "$WP_DIR/wp-config-sample.php" "$WP_DIR/wp-config.php"
    sed -i "s/database_name_here/$DB_NAME/" "$WP_DIR/wp-config.php"
    sed -i "s/username_here/$DB_USER/" "$WP_DIR/wp-config.php"
    sed -i "s/password_here/$DB_PASS/" "$WP_DIR/wp-config.php"
    SALT=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
    sed -i "/AUTH_KEY/d;/SECURE_AUTH_KEY/d;/LOGGED_IN_KEY/d;/NONCE_KEY/d;/AUTH_SALT/d;/SECURE_AUTH_SALT/d;/LOGGED_IN_SALT/d;/NONCE_SALT/d" "$WP_DIR/wp-config.php"
    echo "$SALT" >> "$WP_DIR/wp-config.php"

    create_nginx_config "$DOMAIN" "$WP_DIR"

    sudo nginx -t && sudo systemctl reload nginx
    sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN" --non-interactive --agree-tos -m "$EMAIL" --redirect

    echo "✅ Đã cài WordPress cho https://$DOMAIN"
}

function create_nginx_config() {
    DOMAIN=$1
    WEBROOT=$2
    NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"

    sudo tee "$NGINX_CONF" > /dev/null <<EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    root $WEBROOT;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

    sudo ln -s "$NGINX_CONF" "/etc/nginx/sites-enabled/$DOMAIN"
}

function add_domain() {
    read -p "🌐 Domain: " DOMAIN
    read -p "📁 Thư mục gốc (mặc định: /var/www/$DOMAIN): " WEBROOT
    WEBROOT=${WEBROOT:-/var/www/$DOMAIN}

    sudo mkdir -p "$WEBROOT"
    echo "<h1>$DOMAIN is working!</h1>" | sudo tee "$WEBROOT/index.html"
    sudo chown -R www-data:www-data "$WEBROOT"
    sudo chmod -R 755 "$WEBROOT"

    create_nginx_config "$DOMAIN" "$WEBROOT"
    sudo nginx -t && sudo systemctl reload nginx

    echo "✅ Domain $DOMAIN đã được thêm (chưa có SSL)."
}

function delete_domain() {
    read -p "🌐 Domain cần xoá: " DOMAIN
    sudo rm -f "/etc/nginx/sites-enabled/$DOMAIN"
    sudo rm -f "/etc/nginx/sites-available/$DOMAIN"
    sudo rm -rf "/var/www/$DOMAIN"
    sudo nginx -t && sudo systemctl reload nginx
    echo "❌ Đã xoá $DOMAIN"
}

function install_ssl() {
    read -p "🌐 Domain cần cài SSL: " DOMAIN
    read -p "📧 Email (để đăng ký SSL): " EMAIL
    sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN" --non-interactive --agree-tos -m "$EMAIL" --redirect
    echo "✅ SSL đã được cài cho https://$DOMAIN"
}

while true; do
    echo ""
    echo "===== 📋 MENU QUẢN TRỊ WEBSERVER ====="
    echo "1. Cài đặt Webserver (LEMP)"
    echo "2. Cài đặt Webserver + WordPress"
    echo "3. Thêm domain"
    echo "4. Xoá domain"
    echo "5. Cài SSL cho domain"
    echo "0. Thoát"
    echo "======================================"
    read -p "👉 Nhập lựa chọn (0-5): " OPTION

    case $OPTION in
        1) install_lemp ;;
        2) install_wp_site ;;
        3) add_domain ;;
        4) delete_domain ;;
        5) install_ssl ;;
        0) echo "👋 Tạm biệt!"; exit ;;
        *) echo "❌ Tuỳ chọn không hợp lệ." ;;
    esac
done
