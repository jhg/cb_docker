#!/bin/bash
# This manage the CB app in the Docker container

# Use a default Chicago Boss app name by default
if [ "$1" == '' ]; then
  CBAPP='cbapp'
else
  CBAPP="$1"
fi

# Wrap Chicago Boss init script
function cbinit {
  # TODO: get new code for hot-reload
  # Recompile code for hot-reload
  if [ "$1" == "reload" ]; then
    echo 'Executing rebar compile'
    rebar compile
  fi
  echo "Executing /opt/$CBAPP/init.sh $@"
  /opt/$CBAPP/init.sh $@
}

# Set signals for control from outside of container
echo 'Setting signals trap for manage container...'
trap 'cbinit stop' SIGTERM SIGQUIT SIGINT
trap 'cbinit reload' SIGHUP

echo 'Chicago Boss app in /opt/cbapp starting...'
cbinit start

echo 'Waiting signals...'
wait

echo 'Stoping container...'
