#!/usr/bin/env bash

VERSION="3.4.4"
THREADS=8

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# install dependencies

cd $SCRIPTPATH

cv_install_deps() {
    cd $SCRIPTPATH
    ./install_deps.sh >/dev/null
}

cv_download() {
    cd $SCRIPTPATH
    wget -q --show-progress -O opencv.zip https://github.com/opencv/opencv/archive/$VERSION.zip
    wget -q --show-progress -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$VERSION.zip
}

cv_extract() {
    cd $SCRIPTPATH

    [ -d "opencv" ] && rm -r opencv
    unzip -q opencv.zip
    mv opencv-$VERSION opencv
    rm opencv.zip

    [ -d "opencv_contrib" ] && rm -r opencv_contrib
    unzip -q opencv_contrib.zip
    mv opencv_contrib-$VERSION opencv_contrib
    rm opencv_contrib.zip
}

cv_install() {
    cd $SCRIPTPATH
    cd opencv
    mkdir -p build
    cd build
    cmake --quite -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=$SCRIPTPATH/opencv_contrib/modules -D OPENCV_ENABLE_NONFREE=ON -D BUILD_EXAMPLES=ON ..
    make -j$THREADS
    sudo make install
    sudo ldconfig
    cp install_manifest.txt $SCRIPTPATH
}

cv_verify_install() {
    VVERSION=$(pkg-config --modversion opencv)
    if [ "$VERSION" = "$VVERSION" ]; then
        echo "success."
    else
        echo "verification failed."
    fi
}

echo "INSTALLING DEPENDENCIES..."
cv_install_deps
echo "DOWNLOADING..."
cv_download
echo "EXTRACTING"
cv_extract
echo "INSTALLING OPENCV $VERSION..."
cv_install
echo "VERIFY INSTALLATION..."
cv_verify_install
