#!/usr/bin/env bash

VERSION="latest"

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

git clone https://github.com/Kitware/CMake.git
cd CMake

if [[ "$VERSION" != "latest" ]]; then
    git checkout v$VERSION
fi

cd ..

mkdir build
cd build
../CMake/bootstrap
make
sudo make install