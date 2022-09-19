#!/bin/bash
sudo chmod 777 /mnt
sudo mkdir /mnt/1
sudo mkdir /mnt/2
sudo mkdir /mnt/3
sudo mkdir /home/ubuntu
sudo chmod 777 /home/ubuntu
sudo mkdir /home/ubuntu/SA
sudo mkdir /home/ubuntu/SA/1
sudo mkdir /home/ubuntu/SA/2
sudo mkdir /home/ubuntu/SA/3
sudo mkdir /home/ubuntu/SA/4
sudo chmod 777 /home/ubuntu/SA /home/ubuntu/SA/ /mnt/1 /mnt/2 /mnt/3
wget wget https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/ploter16core.tar
mv ./ploter16core.tar /home/ubuntu/ploter.tar
tar -xf /home/ubuntu/ploter.tar -C /home/ubuntu/
sudo dpkg --install 2.deb
sudo dpkg --install 3.deb
sudo dpkg --install 4.deb
sudo pkill c1
sudo pkill c2
sudo pkill c3
sudo pkill c4
nohup /home/ubuntu/c1  > c1.log & 
nohup /home/ubuntu/c2  > c2.log & 
nohup /home/ubuntu/c3  > c3.log & 


