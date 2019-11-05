# Software Installer For Ubuntu 18.04 (WIP: other distributions)

## CUDA
Change "VERSION" string in "installer.sh" to select a particular cuda version.
Supported Versions are 10.1, 10.0, 9.2, 9.1, 9.0
Default cuda version is: 10.1

### Notes
Note that this installation installs NVidia driver.
Once a NVidia driver exists on the system, the user will be asked if they should be overwritten.
So if you need a specific NVidia driver, install it previously.

### Usage
Installation: ./cuda/installer.sh
Uninstallation: ./cuda/uninstaller.sh

## OpenCV
Change "VERSION" string in "installer.sh" to select a particular OpenCV version.
Supported Versions refer to the github repository tags of: https://github.com/opencv/opencv

### Notes
OpenCV will be installed to /usr/local per default.

### Usage
Installation: ./opencv/installer.sh
Uninstallation: ./opencv/uninstaller.sh
