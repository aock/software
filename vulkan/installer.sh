#!/usr/bin/env bash

VERSION="1.1.130"

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

KEYLINK="http://packages.lunarg.com/lunarg-signing-key-pub.asc"
REPOLINK="http://packages.lunarg.com/vulkan/${VERSION}/lunarg-vulkan-${VERSION}-bionic.list"

echo "Download Vulkan (${VERSION})"

wget -qO - ${KEYLINK} | sudo apt-key add -
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.1.130-bionic.list ${REPOLINK}
sudo apt update
sudo apt install vulkan-sdk