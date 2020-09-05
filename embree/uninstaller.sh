#!/usr/bin/env bash

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd $SCRIPTPATH

if [ -d "embree" ]; then
    cd embree
    sudo rpm --erase embree-lib
    sudo rpm --erase embree-devel
    sudo rpm --erase embree-examples
else
    echo "Nothing to remove."
fi

