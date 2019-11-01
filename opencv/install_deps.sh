#!/usr/bin/env bash

sudo add-apt-repository -r "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

sudo apt-get update

sudo apt-get install libjpeg-dev libpng-dev libtiff-dev
sudo apt-get install libjasper1 libjasper-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev
sudo apt-get install libgtk-3-dev
sudo apt-get install libatlas-base-dev gfortran
sudo apt-get install python3-pip
python3 -m pip install numpy