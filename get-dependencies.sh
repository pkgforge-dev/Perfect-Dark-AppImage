#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake    \
    libdecor \
    python   \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building Perfect Dark..."
echo "---------------------------------------------------------------"
REPO="https://github.com/fgsfdsfgs/perfect_dark"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./perfect_dark
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./perfect_dark
cmake -G"Unix Makefiles" -Bbuild -DCMAKE_BUILD_TYPE=Release .
cmake --build build -j$(nproc)

if [ "$ARCH" = "x86_64" ]; then
    mv -v build/pd.$ARCH ../AppDir/bin/pd
else
    mv -v build/pd.arm64 ../AppDir/bin/pd
fi
