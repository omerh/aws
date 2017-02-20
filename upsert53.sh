#!/bin/bash
# $1 DNS RECORD
# $2 IP address / CNAME
# $3 Type A/CNAME 
# $4 TTL

if [ "$#" = 0 ]; then
        echo "Error: missing arguments"
        echo "Usage: $0 <DNS Name> <IP Address> <type> <ZONEID> <TTL-optional> defaults 60sec"
        exit 1
fi

if [ $3 ] ; then TYPE=$3 ; else echo "Missing record type" && exit 1 ; fi
if [ $4 ]; then HOSTEDZONEID=$4 ; else echo "Missing record type" && exit 1 ; fi
if [ $5 ]; then TTL=$5 ; else TTL=60 ; fi


JSON="{\"Comment\": \"Update record by `whoami`\",\"Changes\": [{\"Action\": \"UPSERT\",\"ResourceRecordSet\": {\"Name\": \""$1"\",\"Type\": \""$TYPE"\",\"TTL\": "$TTL",\"ResourceRecords\": [{\"Value\": \""$2"\"}]}}]}"

echo $JSON > /tmp/upsert.json

aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID  --change-batch file:///tmp/upsert.json

rm -f /tmp/upsert.json
