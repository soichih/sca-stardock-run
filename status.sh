container=`cat container.name`

docker inspect --type=container $container -f {{.State.Running}}
