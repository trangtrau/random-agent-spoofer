#!/bin/bash
sudo -s -H sh -c 'cd && apt install -y wget && wget -O install-docker-ubuntu.sh http://ngockieu.uocnv.com/scripts/install-docker-ubuntu.sh && chmod +x install-docker-ubuntu.sh && ./install-docker-ubuntu.sh && rm -rf install-docker-ubuntu.sh'
