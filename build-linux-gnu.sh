#!/bin/bash
# Usage: build-linux.sh <Qt5|Qt6> <Release|Debug>

set -e
set -o pipefail

buildType=$1
backend=$2
arch=$3

if [$arch == "armel" ]; then
    export TARGET_ARCH="armv6+nofp"
elif [ $arch == "armhf" ]; then
    export TARGET_ARCH="armv6+fp"
fi

apt update
apt install -y build-essential git gcc-14 cmake xvfb

if [ $backend == "Qt5" ]; then
    apt install -y qtbase5-dev libqt5webchannel5-dev qtwebengine5-dev
elif [ $backend == "Qt6" ]; then
    apt install -y qt6-base-dev qt6-declarative-dev qt6-svg-dev qt6-webchannel-dev qt6-webengine-dev
fi

cd saucer
mkdir build
cd build
cmake .. -Dsaucer_bindings=ON -Dsaucer_backend=$backend
cmake --build . --config $buildType
