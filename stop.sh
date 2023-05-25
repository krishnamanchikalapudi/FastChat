#!/bin/bash
DATE_TIME=`date '+%Y-%m-%d %H:%M:%S'`

#linus
# pids=`lsof -i -P -n | grep python3 | awk '{print $2}'`

# mac
pids=`ps uax | grep fastchat | awk '{print $2}'`
serviceIds=(${pids})
idsCount=(${#serviceIds[@]} - 1)

printf "\n -------------------- [BEGIN at {`date '+%Y-%m-%d %H:%M:%S'`}] -------------------- \n "
printf "    # # ### #   #               ###  #   ## ###  ## # #  #  ###  \n "
printf "    # #  #  #   #               #   # # #    #  #   # # # #  #   \n "
printf "    ##   #  #   #       ###     ##  ###  #   #  #   ### ###  #   \n "
printf "    # #  #  #   #               #   # #   #  #  #   # # # #  #   \n "
printf "    # # ### ### ###             #   # # ##   #   ## # # # #  #   \n "

printf "\nPIDs: ${serviceIds}\n"
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

printf "\n -------------------- [END at {`date '+%Y-%m-%d %H:%M:%S'`}] -------------------- \n "
