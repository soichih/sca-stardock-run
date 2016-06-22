container=`cat container.name`
cid=`docker ps -aqf "name=$container"`
status=docker inspect --type=container -f {{.State.Running}} $container

port=`awk '{split($0,a,":"); print a[2]}' container.port`
host=`hostname`
if $status;
then
  curl -X POST -H "Content-Type: application/json" -d "{\"msg\":\"Container started\",\"port\":\"$port\",\"host\":\"$host\",\"container\":\"$cid\"}" $SCA_PROGRESS_URL
fi
