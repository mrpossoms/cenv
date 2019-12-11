#!/bin/bash

source .cenv.utils
cenv_setup

TOOLCHAIN_NAME="arm-linux-gnueabihf-gcc-alx2"
TOOLCHAIN_AR=gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf.tar.xz
TOOLCHAIN_URL="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/8.3-2019.03/binrel/$TOOLCHAIN_AR"

if file_missing .cache/$TOOLCHAIN_AR; then
	echo "Downloading toolchain: '$TOOLCHAIN_AR'..."
	curl -o .cache/$TOOLCHAIN_AR $TOOLCHAIN_URL 
else
	echo "$TOOLCHAIN_AR cached, using"
fi

mkdir -p toolchains/$TOOLCHAIN_NAME
tar xf .cache/$TOOLCHAIN_AR -C toolchains/$TOOLCHAIN_NAME --strip-components 1
if [ $? -ne 0 ]; then
	echo 'Extraction failed, removing erroneous cached toolchain'
	rm -rf toolchains/$TOOLCHAIN_NAME
	rm -rf .cache/$TOOLCHAIN_AR
fi
