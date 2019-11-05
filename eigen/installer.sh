#!/usr/bin/env bash
VERSION="3.3.7"
THREADS=8

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

eigen_download() {
    cd $SCRIPTPATH
    wget -q --show-progress -O eigen.tar.bz2 http://bitbucket.org/eigen/eigen/get/$VERSION.tar.bz2
    mkdir tmp
    tar -xjf eigen.tar.bz2 -C tmp
    rm eigen.tar.bz2
    DIRNAME=$(ls tmp)
    [ -d "eigen" ] && rm -rf eigen
    mv tmp/$DIRNAME eigen
    rm -r tmp
}

eigen_install() {
    cd $SCRIPTPATH
    cd eigen
    mkdir -p build
    cd build
    cmake --quite -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
    make -j$THREADS
    sudo make install
}

eigen_verify() {
    cd $SCRIPTPATH
    cd cmake_test
    mkdir -p build
    cd build
    cmake ..
    make
    VVERSION=$(./example)
    if [[ "$VERSION" == "$VVERSION" ]]; then
        echo "cmake success."
    else
        echo "cmake test failed."
    fi
}

echo "Downloading Eigen Library version: $VERSION"
eigen_download

echo "Installing..."
eigen_install

echo "Verify Installation..."
eigen_verify



