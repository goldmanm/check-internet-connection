#!/bin/bash
echo -e "time\t\t\tinternet\trouter\tprevious duration (seconds)"
TIMESTAMP=`date +%s`
ping -c 1 -W 0.7 8.8.4.4 > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo -e "`date +%Y-%m-%dT%H:%M:%S%Z`\tonline\t\tonline\tn/a";
    INTERNET_STATUS="UP"
else
    INTERNET_STATUS="DOWN"
    ping -c 1 -W 0.7 192.168.1.1 > /dev/null 2>&1
    if [ $? -eq 0] ; then
        echo -e "`date +%Y-%m-%dT%H:%M:%S%Z`\toffline\t\tonline\tn/a"
        ROUTER_STATUS="UP"
    else
        echo -e "`date +%Y-%m-%dT%H:%M:%S%Z`\toffline\t\toffline\tn/a"
        ROUTER_STATUS="DOWN"
    fi
    
fi
while [ 1 ]
 do
    ping -c 1 -W 0.7 8.8.4.4 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        if [ "$INTERNET_STATUS" != "UP" ]; then
            echo -e "`date +%Y-%m-%dT%H:%M:%S%Z`\tonline\t\tonline\t$((`date +%s`-$TIMESTAMP))"
            INTERNET_STATUS="UP"
            TIMESTAMP=`date +%s`
        fi
    else
        if [ "$INTERNET_STATUS" = "UP" ]; then
            ping -c 1 -W 0.7 192.168.1.1 > /dev/null 2>&1
            if [ $? -eq 0 ]; then
                if [ "$ROUTER_STATUS" != "UP" ]; then
                    echo -e "`date +%Y-%m-%dT%H:%M:%S%Z`\toffline\t\tonline\t$((`date +%s`-$TIMESTAMP))"
                    ROUTER_STATUS="UP"
                    INTERNET_STATUS="DOWN"
                    TIMESTAMP=`date +%s`
                fi
            else
                if [ "$ROUTER_STATUS" = "UP" ]; then
                    echo -e "`date +%Y-%m-%dT%H:%M:%S%Z`\toffline\t\toffline\t$((`date +%s`-$TIMESTAMP))"
                    ROUTER_STATUS="DOWN"
                    INTERNET_STATUS="DOWN"
                    TIMESTAMP=`date +%s`
                fi
            fi
        echo "internet not connected with status up"
        fi
    fi
    sleep 1
 done;
