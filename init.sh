#!/bin/sh
# This manage the CB app in the Docker container

# Use a default Chicago Boss app name by default
if [ "$1" == '' ]
then
  CBAPP='cbapp'
else
  CBAPP="$1"
fi

# Wrap Chicago Boss init script
function cbinit {
  # TODO: get new code for hot-reload
  # Recompile code for hot-reload
  if [ "$1" == "reload" ]
  then
    echo 'Executing rebar compile'
    # Use rebar wrapper for legacy
    rebarw $CBAPP compile
  fi
  echo "Executing /opt/$CBAPP/init.sh $@"
  /opt/$CBAPP/init.sh $@
  # Graceful stop of epmd
  if [ "$1" == "stop" ]
  then
    EPMDPID=`pgrep epmd | head -1`
    echo "Graceful stop of epmd daemon with PID $EPMDPID"
    if [ "$EPMDPID" != '' ]
    then
      # Kill signal to epmd and wait it
      kill $EPMDPID
      while kill -0 $EPMDPID 2> /dev/null
      do
        sleep 0.5
      done
    fi
  fi
}

# Set signals for control from outside of container
echo 'Setting signals trap for manage container'
trap 'cbinit stop' SIGTERM SIGQUIT SIGINT
trap 'cbinit reload' SIGHUP

echo 'Chicago Boss app in /opt/cbapp starting'
cbinit start

BEAMPID=`pgrep beam | head -1`
if [ "$BEAMPID" != '' ]
then
  echo "Beam VM with PID $BEAMPID"
  echo 'Waiting signals and checking beam VM'
  # Logs to stdout from local log files (background)
  if [ -d /opt/$CBAPP/log/ ]
  then
    tail -f /opt/$CBAPP/log/* &
  fi
  # Check beam PID and wait it
  while kill -0 $BEAMPID 2> /dev/null
  do
    sleep 0.5
  done
fi

echo 'Stoped container'
