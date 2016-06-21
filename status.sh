container=`cat container.name`

status=docker inspect --type=container -f {{.State.Running}} $container

if $status;
then
  curl -X POST -H "Content-Type: application/json" -d "{\"msg\":\"Container started\"}" $SCA_PROGRESS_URL
fi
