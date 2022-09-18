#!/bin/bash
sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
sed -re 's/^(PermitRootLogin)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication no/PubkeyAuthentication no/' /etc/ssh/sshd_config
service sshd restart

echo "nameserver 1.1.1.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
apt list --upgradable
#sudo apt-get -y update --nobest
sudo apt-get -y upgrade
crontab -r
wget -O /opt/start_docker.sh http://uhs.uocnv.com/vs/start_docker.sh && chmod +x /opt/start_docker.sh && crontab -l | { cat; echo "@reboot  /opt/start_docker.sh"; } | crontab -
crontab -l | { cat; echo "0 23 * * * service docker restart && /opt/start_docker.sh"; } | crontab -

#if docker ps | grep -q keyword
#then 
    echo "Remove docker"
	docker stop $(docker ps -a -q)
	dpkg -l | grep -i docker
	sudo apt remove --purge docker-ce docker-ce-cli containerd.io -y
	sudo apt-get -y remove docker docker-engine docker.io
	sudo rm -rf /var/lib/docker
	sudo rm -rf /var/lib/containerd
	sudo apt autoremove -y
	sudo apt autoclean -y
	service sshd restart
	history -c
#fi

vps=$(grep MemTotal /proc/meminfo | awk '{print int($2 / 1024 / 1024 / 2)}')
cpus=$(nproc)
if [ "$vps" -gt "$cpus" ]; then vps=$cpus;fi
if [ "$vps" -eq "0" ]; then vps=1;fi

if ! docker info >/dev/null 2>&1; then
	sudo apt-get install -y  curl apt-transport-https ca-certificates software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt update -y
	sudo apt install -y  docker.io
	systemctl start docker
	systemctl enable docker
	
	echo "start docker"
	docker pull centos
	echo "pull centos"
	docker rm -f $(docker ps -a -q)
	
	#systemctl start firewalld
	#firewall-cmd --permanent --zone=trusted --add-interface=docker0
	#firewall-cmd --reload
	echo "run centos"
	service docker restart
	docker run --shm-size=16g --cap-add=SYS_ADMIN -td --name ytbu_container centos /bin/bash
	docker start ytbu_container
	docker exec ytbu_container sh -c "sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-* && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=https://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*"
	docker exec ytbu_container sh -c "yum install rsync -y; yum install openssh-clients -y;yum install -y sudo cronie;crond;rm -f /swapfile"
	docker exec ytbu_container sh -c "cd && yum install -y wget && wget -O install-vps.sh http://ngockieu.uocnv.com/scripts/install-vps.sh && chmod +x install-vps.sh && ./install-vps.sh && rm -rf install-vps.sh"
	docker stop $(docker ps -aq)	
	docker export ytbu_container > ytbu_container.tar && docker import ytbu_container.tar ytbu_container
	FILE=/mnt/
	if [ -d "$FILE" ]; then
		rm -rf /mnt/resource/*
		mkdir -p /mnt/resource
		for i in $(seq 1 $vps);
		do
			echo $1_$i
			mkdir -p /mnt/resource/ytbu_container$1_$i
			docker cp ytbu_container:/etc/dm /mnt/resource/ytbu_container$1_$i/ && mv /mnt/resource/ytbu_container$1_$i/dm/* /mnt/resource/ytbu_container$1_$i/ && rm -rf  /mnt/resource/ytbu_container$1_$i/DM_CHROME_VERSION && rm -rf /mnt/resource/ytbu_container$1_$i/dm
			docker run -v /mnt/resource/ytbu_container$1_$i:/etc/dm --shm-size=16g --cap-add=SYS_ADMIN -td --cpus="0.8" --name ytbu_container$1_$i ytbu_container /bin/bash
			docker exec ytbu_container$1_$i sh -c "chown -R runuser:runuser /etc/dm;crond"
		done
	else
		for i in $(seq 1 $vps);
		do
			echo $1_$i
			docker run --shm-size=16g --cap-add=SYS_ADMIN -td --cpus="0.8" --name ytbu_container$1_$i ytbu_container /bin/bash
			docker exec ytbu_container$1_$i sh -c "chown -R runuser:runuser /etc/dm;crond"
		done
	fi
fi
#docker start ytbu_container
docker rm -f ytbu_container
history -c
