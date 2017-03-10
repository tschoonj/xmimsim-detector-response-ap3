#!/usr/bin/env bash

set -e
set -x

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

cd $APPVEYOR_BUILD_FOLDER
autoreconf -fi
export CPPFLAGS=-I/usr/local/include
export CFLAGS="-Wno-deprecated -Wno-deprecated-declarations"
export CXXFLAGS="-Wno-deprecated -Wno-deprecated-declarations"
./configure
make
make check
make distcheck
mv .libs/*.dll .
