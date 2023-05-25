#!/bin/bash

#linux
# pids=`lsof -i -P -n | grep python3 | awk '{print $2}'`

# mac
pids=`ps uax | grep fastchat | awk '{print $2}'`

serviceIds=(${pids})
printf "\nPIDs: ${serviceIds}\n"

idsCount=(${#serviceIds[@]} - 1)
printf "\nPIDs count: ${idsCount}\n"

for (( i=0; i< $idsCount; i++ ));
do
  :
    serviceId=${serviceIds[$i]}
    printf "\n%s\n" "ServiceId[$i]: ${serviceId} killed! "
    if [ ! -z "$serviceId" ]; then
        kill -9 ${serviceId} &
    fi
done
