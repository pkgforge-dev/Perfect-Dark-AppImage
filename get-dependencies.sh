#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake    \
    libdecor \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
echo "Making nightly build of Perfect Dark..."
echo "---------------------------------------------------------------"
REPO="https://github.com/fgsfdsfgs/perfect_dark"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./perfect_dark
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./perfect_dark
cmake -G"Unix Makefiles" -Bbuild .
cmake --build build -j$(nproc)
mv -v build/pd.$arch ./AppDir/bin
