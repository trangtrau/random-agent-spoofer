#!/bin/bash
wget https://github.com/trangtrau/random-agent-spoofer/releases/download/SA/bladebit
chmod 775 bladebit
chmod 777 /mnt/
mkdir /mnt/1 /mnt/2 /mnt/3 /mnt/4
chmod 777 /mnt/1 /mnt/2 /mnt/3 /mnt/4
while [ true ]
do
count=`pgrep bladebit |  grep -o -E '[0-9]+'`
if [[ $count -gt 10 ]]
then
  echo "dang ton tai"
else
count1=`find /mnt/1/ -type f -name "*.doc" | wc -l`
  while [ $count -lt 1 ]
do
./bladebit -w -t 94 -n 1 -f b087e3e77f595e85a19a0761543eafd7321ec045252421546157c124517d2f2cfbda5df17665108812898238e3a5aba8 -p 8ecf7f3fe9fe70f83999246b86832547ff9f705a736fc624f14518c8dbc49598e0d385f11fb83fb1a8ed8582df8e6c13  diskplot -a --cache 99G -t1 /mnt/  /mnt/1
done


count2=`find /mnt/2/ -type f -name "*.doc" | wc -l`
  while [ $count2 -lt 1 ]
do
./bladebit -w -t 94 -n 1 -f b087e3e77f595e85a19a0761543eafd7321ec045252421546157c124517d2f2cfbda5df17665108812898238e3a5aba8 -p 8ecf7f3fe9fe70f83999246b86832547ff9f705a736fc624f14518c8dbc49598e0d385f11fb83fb1a8ed8582df8e6c13  diskplot -a --cache 99G -t1 /mnt/ /mnt/2
done


count3=`find /mnt/1/ -type f -name "*.doc" | wc -l`
  while [ $count3 -lt 3 ]
do
.bladebit -w -t 94 -n 1 -f b087e3e77f595e85a19a0761543eafd7321ec045252421546157c124517d2f2cfbda5df17665108812898238e3a5aba8 -p 8ecf7f3fe9fe70f83999246b86832547ff9f705a736fc624f14518c8dbc49598e0d385f11fb83fb1a8ed8582df8e6c13 diskplot -a --cache 99G -t1 /mnt/  /mnt/3
done




sleep 5
fi
sleep 5
	
done
