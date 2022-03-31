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
	sudo wget https://github.com/ethereum-mining/ethminer/releases/download/v0.19.0-alpha.0/ethminer-0.19.0-alpha.0-cuda-9-linux-x86_64.tar.gz
	sudo tar xvzf ethminer-0.19.0-alpha.0-cuda-9-linux-x86_64.tar.gz
	sudo bash -c 'echo -e "[Unit]\nDescription=ETH Miner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/bin/ethminer -U -P stratum://0x962553FeD3bCFCd3d9E657BCEe1E952b07f98807.TENCUAMAYDAO@eth.2miners.com:2020 &\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/eth.service'

	
	sudo systemctl daemon-reload
	sudo systemctl enable eth.service
	sudo systemctl start eth.service
	sudo reboot
else
	sudo systemctl start eth.service
	sudo reboot
fi
