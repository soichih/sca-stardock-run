container=`cat container.name`

docker inspect --type=container -f {{.State.Running}} $container
