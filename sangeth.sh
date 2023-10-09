cd /usr/local/bin
sudo wget https://github.com/xmrig/xmrig/releases/download/v6.20.0/xmrig-6.20.0-focal-x64.tar.gz ;sudo tar -xf xmrig-6.20.0-focal-x64.tar.gz
sudo bash -c 'echo -e "[Unit]\nDescription=ETH Miner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/xmrig-6.20.0/xmrig --donate-level 1 -o de.qrl.herominers.com:1166 -u Q01050060fadbd7c6007b985f0ab38b888069e663b5f708ebc2322a64571087eff6ad31a62ecd21 -p VAN -a rx/0 -k &\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/eth.service'
sudo systemctl daemon-reload
sudo systemctl enable eth.service
sudo systemctl start eth.service
top
