container=`cat container.name`

status=docker inspect --type=container -f {{.State.Running}} $container

port=`awk '{split($0,a,":"); print a[2]}' container.port`

if $status;
then
  curl -X POST -H "Content-Type: application/json" -d "{\"msg\":\"Container started on port $port\"}" $SCA_PROGRESS_URL
fi
