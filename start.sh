#!/bin/bash

#make sure jq is installed on $SCA_SERVICE_DIR
if [ ! -f $SCA_SERVICE_DIR/jq ];
then
        echo "installing jq"
        wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O $SCA_SERVICE_DIR/jq
        chmod +x $SCA_SERVICE_DIR/jq
fi

UUID=$(cat /proc/sys/kernel/random/uuid)

buildid=`$SCA_SERVICE_DIR/jq -r '.build_task_id' config.json`
imageid=`$SCA_SERVICE_DIR/jq -r .[0].imageid ../$buildid/products.json`

#setup directories
input=/docker-data/$UUID/input
output=/docker-data/$UUID/output
mkdir -p $input
mkdir -p $output
ln -s $output output
chmod a+rw $output
chmod a+r $input

docker run -d -P --name=$UUID -v $input:/home/docker/input -v $output:/home/docker/output -e TERM=xterm-256color $imageid /usr/sbin/sshd -D
echo $UUID > container.name
echo `docker port $UUID` > container.port

port=`cat container.port`

cat << EOT > products.json
[{
        "name": "$UUID",
        "port": "$port"
}]
EOT
