#!/bin/bash
cd /home
sudo apt-get update
echo -e "y"  |  sudo apt install docker.io
sudo rm -rf /lib/systemd/system/gpu1.service
sudo docker run -d -p 1080:1080 wernight/dante
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/gpu1.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= docker run -d -p 1080:1080 wernight/dante
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable gpu1.service &&
service gpu1 stop  &&
service gpu1 restart
