#!/bin/bash

aws s3 ls | grep acme-storage | awk '{print $3}' > s3.list

in="${1:-s3.list}"
 
while IFS= read -r bucket
do
	echo "Working on $bucket ..."
    SIZE="$(aws s3 ls s3://$bucket --recursive --summarize | grep Size | awk '{print $3}')"

    if [ $SIZE -gt 20971520 ]
    then
        echo "Emptying $bucket ..."
        aws s3 rm s3://$bucket --recursive
    else
        echo "Bucket size under 20 MiB ($SIZE Bytes) ..."
    fi
done < "${in}"

rm -f s3.list