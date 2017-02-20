#!/bin/bash

NODES=`aws ec2 describe-instances --region us-west-1 --output table | grep PrivateIpAddress | grep -o -E '192.168\.\d+\.\d+'`

for i in ${NODES[@]}; do
	ssh -o StrictHostKeyChecking=no -t ec2-user@$i -i ~/.ssh/your.pem "commands; exit"
done
