#!/usr/bin/env bash

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

cd build
sudo make uninstall