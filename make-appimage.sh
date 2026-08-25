#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/perfect-dark-pc-port/perfect_dark/refs/heads/port/dist/linux/io.github.perfect_dark_pc_port.perfect_dark.png
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun ./AppDir/bin/pd

# Turn AppDir into AppImage
quick-sharun --make-appimage
