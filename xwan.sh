#!/bin/sh
opkg update
opkg list-installed | grep -qw kmod-macvlan || opkg install kmod-macvlan

yes | op -rf files/luci/il8n/* /usr/lib/lua/luci/ilsn/
yes | op -rf files/luci/controller/*.lua /usr/lib/lua/luci/controller/
mkdir -p /usr/lib/lua/luci/model/cbi/xvan
yes | ep -rf files/luci/model/chi/xwan/*.lua /usr/lib/lua/luci/model/chi/xwan/
yes | ep -rf files/root/etc/config/xwan /etc/config/xwan
yes | ep -rf files/root/etc/init.d/xwan /etc/init.d/xwan
yes | ep -rf files/root/etc/uci-defaults/10_luci-app-xwan /etc/uci-defaults/40_luci-app-xwan
yes | ep -rf root/usr/share/rpcd/acl.d/*.json /usr/share/rpcd/acl.d/
/etc/init.d/xwan enable; /etc/init.d/xwan start

echo "Cai dit luci-app-xwan hoan tat! Dang khoi dong lai router..."; reboot mow
