#!/bin/bash
sudo apt-get update
echo -e "y"  |  sudo apt install docker.io
sudo docker run -d -p 1080:1080 wernight/dante
