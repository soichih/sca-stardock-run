#!/bin/bash

#make sure jq is installed on $SCA_SERVICE_DIR
if [ ! -f $SCA_SERVICE_DIR/jq ];
then
        echo "installing jq"
        wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O $SCA_SERVICE_DIR/jq
        chmod +x $SCA_SERVICE_DIR/jq
fi

UUID=$(cat /proc/sys/kernel/random/uuid)

buildid=`./jq -r '.[build_task_id]' config.json`
docker -d -P --name=$UUID $buildid /usr/sbin/sshd -D
echo $UUID > container.name
