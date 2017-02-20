#/bin/bash

for i in `aws cloudfront list-distributions --query 'DistributionList.Items[*].{Id:Id}' | grep \"Id\"\: | cut -d'"' -f4` ; do
	aws cloudfront create-invalidation --distribution-id $i --paths /robots.txt
done