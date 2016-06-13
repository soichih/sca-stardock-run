container=`cat container.name`

docker inspect --type=container $container > status.json
