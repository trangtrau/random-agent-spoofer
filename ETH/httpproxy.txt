#!/bin/bash
sudo apt-get update
echo -e "y"  |  sudo apt install nmap
echo -e "y"  |  sudo apt install ncat
sudo rm -rf /lib/systemd/system/httprox.service
sudo rm -rf /var/crash
sudo bash -c 'cat <<EOT >>/lib/systemd/system/httprox.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /usr/bin/ncat -k -4 -l 8000 --proxy-type http
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
sudo systemctl daemon-reload &&
sudo systemctl enable httprox.service &&
sudo service httprox stop  &&
sudo service httprox restart
