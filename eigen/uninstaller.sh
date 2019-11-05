#!/usr/bin/env bash
set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

if [ -d "eigen" ]; then
    cd eigen
    if [ -d "build" ]; then
        cd build
        sudo make uninstall
    fi
    cd $SCRIPTPATH
    rm -rf eigen
fi
