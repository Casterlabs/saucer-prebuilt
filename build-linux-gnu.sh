#!/bin/bash
# Usage: build-linux.sh <Qt5|Qt6> <Release|Debug>

set -e
set -o pipefail

export NONINTERACTIVE=1

buildType=$1
backend=$2
arch=$3

if [$arch == "armel" ]; then
    export TARGET_ARCH="armv6+nofp"
elif [ $arch == "armhf" ]; then
    export TARGET_ARCH="armv6+fp"
fi

apt update
apt install -y curl build-essential git xvfb

if [ $backend == "Qt5" ]; then
    apt install -y qtbase5-dev libqt5webchannel5-dev qtwebengine5-dev
elif [ $backend == "Qt6" ]; then
    apt install -y qt6-base-dev qt6-declarative-dev qt6-svg-dev qt6-webchannel-dev qt6-webengine-dev
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(
    echo
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
) >>/root/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install gcc@14
brew install cmake

echo "Building with $(gcc --version | grep 'gcc') and $(cmake --version | grep 'version')"

export CC="/home/linuxbrew/.linuxbrew/bin/gcc-14"
export CXX="/home/linuxbrew/.linuxbrew/bin/g++-14"

cd saucer
mkdir build
cd build
cmake .. -Dsaucer_bindings=ON -Dsaucer_backend=$backend
cmake --build . --config $buildType
