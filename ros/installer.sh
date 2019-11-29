#!/usr/bin/env bash
VERSION="melodic"

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

ros_prepare() {
    cd $SCRIPTPATH
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
    sudo apt update
}

ros_install() {
    sudo apt-get install ros-$VERSION-desktop-full
    # sudo aptitude install ros-$VERSION-desktop-full
}

ros_postpare() {
    sudo rosdep init
    rosdep update
    echo "source /opt/ros/melodic/setup.bash" >> ~/.rosrc
}

ros_install_build_packages() {
    sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential
}

echo "ROS $VERSION installer."
echo "Preparing..."
ros_prepare
echo "Installing..."
ros_install
echo "Installing build packages..."
ros_install_build_packages
echo "Configurating..."
ros_postpare
echo "Source ~/.rosrc in your bashrc or zshrc to finish installation."
