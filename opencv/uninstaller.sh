#!/usr/bin/env bash

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

echo "REMOVING INSTALLED FILES..."
if [ -f "install_manifest.txt" ]
then
    # cat install_manifest.txt | xargs echo sudo rm | sh
    while read p; do
        echo "$p"
        if [ $p -ot "install_manifest.txt" ]
        then
            sudo rm -r $p
        fi
    done < install_manifest.txt
    rm install_manifest.txt
fi

echo "REMOVING SRC FILES"
[ -d "opencv" ] && rm -rf opencv
[ -d "opencv_contrib" ] && rm -rf opencv_contrib