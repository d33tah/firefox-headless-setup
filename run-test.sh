#!/bin/bash

set -euo pipefail
set -x

# Whatever happens, stop Xvfb on exit.
function stop_xvfb() {
    retcode=$?
    kill $XVFB_PID || true
    exit $retcode
}

# http://stackoverflow.com/q/17944234/1091116
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/
Xvfb :21 -screen 0 1280x800x24 +extension RANDR &
XVFB_PID=$!
trap stop_xvfb EXIT
sleep 5

export DISPLAY=:21
python3 ./manage.py test
