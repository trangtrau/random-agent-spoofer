#!/bin/bash

function install_lemp() {
    echo "Dang cai dat LEMP Stack..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx mysql-server php-fpm php-mysql php-curl php-xml php-mbstring php-zip php-gd unzip wget curl certbot python3-certbot-nginx -y
    echo "LEMP Stack da duoc cai dat."
}

function install_wp_site() {
    read -p "Domain: " DOMAIN
    read -p "DB Name: " DB_NAME
    read -p "DB User: " DB_USER
    read -s -p "DB Password: " DB_PASS; echo
    read -p "Email (dung de dang ky SSL): " EMAIL

    WP_DIR="/var/www/$DOMAIN"

    sudo mysql -e "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    sudo mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
    sudo mysql -e "FLUSH PRIVILEGES;"

    cd /tmp
    wget https://wordpress.org/latest.tar.gz -O wordpress.tar.gz
    tar -xzf wordpress.tar.gz
    sudo mkdir -p "$WP_DIR"
    sudo cp -r wordpress/* "$WP_DIR"
    sudo chown -R www-data:www-data "$WP_DIR"
    sudo chmod -R 755 "$WP_DIR"

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

    echo "Da cai xong WordPress cho https://$DOMAIN"
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

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

    sudo ln -s "$NGINX_CONF" /etc/nginx/sites-enabled/
}

function add_domain() {
    read -p "Domain: " DOMAIN
    read -p "Thu muc goc (mac dinh: /var/www/$DOMAIN): " WEBROOT
    WEBROOT=${WEBROOT:-/var/www/$DOMAIN}

    sudo mkdir -p "$WEBROOT"
    echo "<h1>$DOMAIN is working!</h1>" | sudo tee "$WEBROOT/index.html"
    sudo chown -R www-data:www-data "$WEBROOT"
    sudo chmod -R 755 "$WEBROOT"

    create_nginx_config "$DOMAIN" "$WEBROOT"
    sudo nginx -t && sudo systemctl reload nginx

    echo "Domain $DOMAIN da duoc them (chua co SSL)."
}

function delete_domain() {
    read -p "Domain can xoa: " DOMAIN
    sudo rm -f "/etc/nginx/sites-enabled/$DOMAIN"
    sudo rm -f "/etc/nginx/sites-available/$DOMAIN"
    sudo rm -rf "/var/www/$DOMAIN"
    sudo nginx -t && sudo systemctl reload nginx
    echo "Da xoa $DOMAIN"
}

function install_ssl() {
    read -p "Domain can cai SSL: " DOMAIN
    read -p "Email (dang ky SSL): " EMAIL
    sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN" --non-interactive --agree-tos -m "$EMAIL" --redirect
    echo "SSL da duoc cai dat cho https://$DOMAIN"
}

while true; do
    echo ""
    echo "===== MENU QUAN TRI WEBSERVER ====="
    echo "1. Cai dat Webserver (LEMP)"
    echo "2. Cai dat Webserver + WordPress"
    echo "3. Them domain"
    echo "4. Xoa domain"
    echo "5. Cai SSL cho domain"
    echo "0. Thoat"
    echo "===================================="
    read -p "Chon so (0-5): " OPTION

    case $OPTION in
        1) install_lemp ;;
        2) install_wp_site ;;
        3) add_domain ;;
        4) delete_domain ;;
        5) install_ssl ;;
        0) echo "Tam biet!"; exit ;;
        *) echo "Lua chon khong hop le." ;;
    esac
done
