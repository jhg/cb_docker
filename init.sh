#!/bin/bash
# This manage the CB app in the Docker container

echo 'Chicago Boss app in /opt/cbapp starting...'
/opt/cbapp/init.sh start

echo 'Setting signals trap for manage container...'
trap '/opt/cbapp/init.sh stop' SIGTERM
trap '/opt/cbapp/init.sh reload' SIGHUP

echo 'Waiting signals...'
wait

echo 'Stoping container...'
