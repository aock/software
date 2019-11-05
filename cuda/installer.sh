#!/usr/bin/env bash

VERSION="10.1"

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

if [[ "$VERSION" == "10.1" ]]; then
    DOWNLOADLINK="http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run"
elif [[ "$VERSION" == "10.0" ]]; then
    DOWNLOADLINK="https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux"
elif [[ "$VERSION" == "9.2" ]]; then
    DOWNLOADLINK="https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux"
elif [[ "$VERSION" == "9.1" ]]; then
    DOWNLOADLINK="https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda_9.1.85_387.26_linux"
elif [[ "$VERSION" == "9.0" ]]; then
    DOWNLOADLINK="https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run"
fi

echo "Download CUDA installer from: $DOWNLOADLINK"

wget -q --show-progress -O cuda.run "$DOWNLOADLINK"
chmod +x cuda.run

# check driver
DRIVERVERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)

re='^[0-9.]+$'

INSTALL_DRIVER=0

if ! [[ $DRIVERVERSION =~ $re ]] ; then
    INSTALL_DRIVER=true
else
    read -e -p "Override GPU driver $DRIVERVERSION? [y/N] " OVERRIDE
    OVERRIDE=${OVERRIDE:-n}

    if [ $OVERRIDE == "y" ]; then
        INSTALL_DRIVER=1
    else
        INSTALL_DRIVER=0
    fi
fi

if [[ $INSTALL_DRIVER == 0 ]]; then
    echo "Installing without drivers..."
    sudo sh cuda.run --silent --toolkit --samples
else
    echo "Installing with new drivers..."
    sudo sh cuda.run --silent --driver --toolkit --samples 
fi

rm cuda.run

echo "Finished! Please either add the commands of .cudarc to .bashrc of your home folder or source the .cudarc from your .bashrc"