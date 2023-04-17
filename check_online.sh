#!/bin/bash

INTERNET_IP="8.8.4.4"
ROUTER_IP="192.168.1.1"

echo -e "time\t\t\tinternet\trouter\tduration (seconds)"
TIMESTAMP=`date +%s`

# initialize the program
ping -c 1 -W 0.7 $INTERNET_IP > /dev/null 2>&1
if [ $? -eq 0 ]; then
    INTERNET_STATUS="online"
else
    INTERNET_STATUS="offline"
fi
ping -c 1 -W 0.7 $ROUTER_IP > /dev/null 2>&1
if [ $? -eq 0 ]; then
    ROUTER_STATUS="online"
else
    ROUTER_STATUS="offline"
fi
echo -en "`date +%Y-%m-%dT%H:%M:%S%Z`\t$INTERNET_STATUS\t\t$ROUTER_STATUS\t"

# check status every second until finished
while [ 1 ]
 do
    # check for internet connection
    ping -c 1 -W 0.7 $INTERNET_IP > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        NEW_INTERNET_STATUS="online"
    else
        NEW_INTERNET_STATUS="offline"
    fi
    # check for router connection
    ping -c 1 -W 0.7 $ROUTER_IP > /dev/null 2>&1 # adjust router IP address here
    if [ $? -eq 0 ]; then
        NEW_ROUTER_STATUS="online"
    else
        NEW_ROUTER_STATUS="offline"
    fi
    # if the status is different than before, print the amount of time on the previous status and the new status
    if [[ ! ( $INTERNET_STATUS = $NEW_INTERNET_STATUS && $ROUTER_STATUS = $NEW_ROUTER_STATUS ) ]]; then
        INTERNET_STATUS=$NEW_INTERNET_STATUS
        ROUTER_STATUS=$NEW_ROUTER_STATUS
        echo -en "$((`date +%s`-$TIMESTAMP))\n`date +%Y-%m-%dT%H:%M:%S%Z`\t$INTERNET_STATUS\t\t$ROUTER_STATUS\t"
        TIMESTAMP=`date +%s`
    fi
    # wait 1 second before retrying
    sleep 1
 done;
