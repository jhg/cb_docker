#!/bin/sh
# Wrapper for Rebar for legacy local Rebar binary
# Check local rebar binary (legacy)
if [ -f /opt/$1/rebar ]; then
  /opt/$1/rebar ${@:2}
else
  /bin/rebar ${@:2}
fi
