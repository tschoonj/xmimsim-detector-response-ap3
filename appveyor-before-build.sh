#!/usr/bin/env bash

set -e
set -x

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# install xraylib
wget -q https://xraylib.tomschoonjans.eu/xraylib-3.2.0.tar.gz
tar xfz xraylib-3.2.0.tar.gz
cd xraylib-3.2.0
./configure
make
make install
cd ..

# install hdf5
wget -q https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.12/src/hdf5-1.8.12.tar.gz
tar xfz hdf5-1.8.12.tar.gz 
cd hdf5-1.8.12
./configure --disable-hl --prefix=/usr/local CPPFLAGS=-D_GNU_SOURCE=1
# patch hdf5 -> https://tschoonj.github.io/blog/2014/01/29/building-a-64-bit-version-of-hdf5-with-mingw-w64/
echo "#ifndef H5_HAVE_WIN32_API" >> src/H5pubconf.h
echo "#ifdef WIN32 /* defined for all windows systems */" >> src/H5pubconf.h
echo "#define H5_HAVE_WIN32_API 1" >> src/H5pubconf.h
echo "#endif" >> src/H5pubconf.h
echo "#endif" >> src/H5pubconf.h
echo "#ifndef H5_HAVE_MINGW" >> src/H5pubconf.h
echo "#ifdef __MINGW32__ /*defined for all MinGW compilers */" >> src/H5pubconf.h
echo "#define H5_HAVE_MINGW 1" >> src/H5pubconf.h
echo "#endif" >> src/H5pubconf.h
echo "#endif" >> src/H5pubconf.h
echo "#define H5_BUILT_AS_DYNAMIC_LIB 1" >> src/H5pubconf.h
make
make install
cd ..

# install easyRNG
wget -q https://easyrng.tomschoonjans.eu/easyRNG-1.0.tar.gz
tar xfz easyRNG-1.0.tar.gz
cd easyRNG-1.0
./configure
make
make install
cd ..

# install xmi-msim from master
#git clone --depth 1 git@github.com:tschoonj/xmimsim.git
wget -q https://github.com/tschoonj/xmimsim/archive/master.tar.gz
tar xfz master.tar.gz
cd xmimsim-master
autoreconf -fi
export CPPFLAGS=-I/usr/local/include
export CFLAGS="-Wno-deprecated -Wno-deprecated-declarations"
export CXXFLAGS="-Wno-deprecated -Wno-deprecated-declarations"
./configure $CONFIGURE_OPTIONS
make
make check
make install
cd ..
