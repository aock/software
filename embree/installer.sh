#!/usr/bin/env bash
VERSION=3.6.1

set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

embree_install_deps() {
    cd $SCRIPTPATH
    ./install_deps.sh
}

embree_download() {
    cd $SCRIPTPATH
    wget -q --show-progress -O embree.rpm.tar.gz https://github.com/embree/embree/releases/download/v$VERSION/embree-$VERSION.x86_64.rpm.tar.gz
}

embree_extract() {
    cd $SCRIPTPATH
    
    [ -d "tmp" ] && rm -rf tmp
    mkdir tmp
    tar -xzf embree.rpm.tar.gz -C tmp
    [ -d "embree" ] && rm -rf embree
    
    mkdir embree
    mv $(ls tmp/embree*-lib*.rpm) embree/embree-lib.rpm
    mv $(ls tmp/embree*-devel*.rpm) embree/embree-devel.rpm
    mv $(ls tmp/embree*-examples*.rpm) embree/embree-examples.rpm
    
    cd embree
    sudo alien embree-lib.rpm
    mv $(ls embree*-lib*.deb) embree-lib.deb
    sudo alien embree-devel.rpm
    mv $(ls embree*-devel*.deb) embree-devel.deb
    sudo alien embree-examples.rpm
    mv $(ls embree*-examples*.deb) embree-examples.deb

    # clean up
    cd $SCRIPTPATH
    rm -r tmp
    [ -f "embree.rpm.tar.gz" ] && rm embree.rpm.tar.gz
}

embree_install() {
    cd $SCRIPTPATH
    cd embree
    sudo dpkg -i embree-lib.deb
    sudo dpkg -i embree-devel.deb
    sudo dpkg -i embree-examples.deb

    # update library
    sudo sh -c 'echo "/usr/lib64" > /etc/ld.so.conf.d/embree.conf'

    # adding symbol link to cmake module path
    # embree -> /usr/lib64/cmake/embree-3.6.1

}

embree_verify() {
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

# echo "Installing dependencies..."
# embree_install_deps

# echo "Downloading Embree $VERSION"
# embree_download

# echo "Extracting files..."
# embree_extract

# echo "Installing Embree $VERSION"
# embree_install

echo "Verify installation..."
embree_verify
