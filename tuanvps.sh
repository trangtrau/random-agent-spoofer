#!/bin/bash
vps=$(grep MemTotal /proc/meminfo | awk '{print int($2 / 1024 / 1024 / 2)}')
cpus=$(nproc)
if [ "$vps" -gt "$cpus" ]; then vps=$cpus;fi
if [ "$vps" -eq "0" ]; then vps=1;fi

rm -rf install_start.sh

apt -y install wget
#sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*

#sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

apt update -y
sleep 2
echo "Dowloading Install Start...."

wget -c http://44.201.182.135/install/tuan/install_start.sh

echo "DONE Install Start!"

sleep 5

echo "nameserver 1.1.1.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt -y remove podman
apt -y remove buildah
apt install -y apt-utils
apt install openssh-clients -y
#apt-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#apt install -y docker-ce-19.03.13 docker-ce-cli-19.03.13 containerd.io
#curl -fsSL https://get.docker.com/ | sh
#apt-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
while ! command -v docker &> /dev/null
do
    #apt install -y docker-ce-19.03.13 docker-ce-cli-19.03.13 containerd.io
	curl -fsSL https://get.docker.com/ | sh
done
systemctl start docker
echo "start docker"
docker pull centos
echo "pull centos"
docker rm -f $(docker ps -a -q)
#firewall-cmd --permanent --zone=trusted --add-interface=docker0
service docker restart
echo "firewall docker0"
#firewall-cmd --reload
echo "run centos"
docker run --shm-size=2g --cap-add=SYS_ADMIN -td --name kytb centos /bin/bash
docker cp install_start.sh kytb:/root/install_start.sh
docker exec kytb sh -c "sh /root/install_start.sh "
docker stop $(docker ps -aq)
docker export kytb > kytb_base.tar && docker import kytb_base.tar kytb_base
service docker restart
sleep 10
for i in $(seq 1 $vps);
do
		echo $1_$i
		docker rm -f kytb$1_$i
		sleep 5
    docker run --shm-size=16g --cap-add=SYS_ADMIN -td --cpus="0.8" --name kytb$1_$i kytb_base /bin/bash
    sleep 5
    docker exec kytb$1_$i sh -c "cd /home/runuser && export DISPLAY=:0"
    docker exec kytb$1_$i sh -c "cd /home/runuser/scripts && pm2 start main.js && pm2 save"

    sleep 5
    if [[ $i -eq 1 ]]
    then
        sudo -u root -H sh -c 'crontab -l' | { echo "0 */4 * * * docker exec kytb$1_$i /home/runuser/scripts/check.sh > /tmp/check.log"; } | sudo -u root -H sh -c ' crontab -'
        sudo -u root -H sh -c 'crontab -l' | { cat; echo "*/30 * * * * docker exec kytb$1_$i /home/runuser/scripts/update.sh > /tmp/update.log"; } | sudo -u root -H sh -c ' crontab -'
    else
        sudo -u root -H sh -c 'crontab -l' | { cat; echo "0 */4 * * * docker exec kytb$1_$i /home/runuser/scripts/check.sh > /tmp/check.log"; } | sudo -u root -H sh -c ' crontab -'
        sudo -u root -H sh -c 'crontab -l' | { cat; echo "*/30 * * * * docker exec kytb$1_$i /home/runuser/scripts/update.sh > /tmp/update.log"; } | sudo -u root -H sh -c ' crontab -'
    fi
    sleep 5
done

docker rm -f kytb
rm -f /kytb_base.tar
dd if=/dev/zero of=/mnt/swapfile bs=2024 count=1048576
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile

sudo bash -c 'echo -e "[Unit]\nDescription=ZYTB Scripts\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=bash /home/install-vps.sh >/tmp/install.log 2>&1 \n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/zytb.service'
sudo systemctl daemon-reload
sudo systemctl enable zytb.service
sudo systemctl start zytb.service

echo "!!!DONE!!!"
