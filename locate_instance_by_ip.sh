#!/bin/bash
ip=$1
regions=( us-east-1 eu-west-1 eu-central-1 us-west-2 ap-northeast-1 ap-southeast-1 ap-southeast-2 sa-east-1 )
for i in "${regions[@]}"; do
a=`ec2-describe-instances --region $i | grep $ip`
if [ "$?" = "0" ]; then
        echo found $ip in $i
        instance=$(echo $a | awk '{print $2}')
        ec2-describe-instances $instance | grep -i "name"
        exit
fi
done
