#!/bin/bash -e

# Where to install the toolchain
if [ "x$PREFIX" == "x" ]; then
    export PREFIX=/opt/toolchains/or1k-elf
fi

# We need the previously installed tools
export PATH=$PATH:$PREFIX/bin

# Build mutlticore variant
if [ "x$BUILD_MULTICORE" == "x" ]; then
    export CFLAGS_PARAM=""
else
    export CFLAGS_PARAM="CFLAGS=-D__OR1K_MULTICORE__"
fi

# Location of newlib repository
if [ "x$NEWLIB_CHECKOUT" == "x" ]; then
    if [ ! -d newlib ]; then
	git clone git://sourceware.org/git/newlib-cygwin.git newlib
    fi
    export NEWLIB_CHECKOUT=$PWD/newlib
fi

# Clone binutils and gdb if necessary
if [ ! -d binutils ]; then
    git clone git://sourceware.org/git/binutils-gdb.git binutils
fi

if [ ! -d gdb ]; then
    git clone https://github.com/openrisc/binutils-gdb.git gdb
fi

# Clone gcc if necessary
if [ ! -d gcc ]; then
    git clone https://github.com/openrisc/or1k-gcc.git gcc
fi

rm -rf build-*

# Build!
echo "++ build binutils"
mkdir build-binutils; cd build-binutils
../binutils/configure --target=or1k-elf --prefix=$PREFIX --disable-itcl --disable-tk --disable-tcl --disable-winsup --disable-gdbtk --disable-libgui --disable-rda --disable-sid --disable-sim --disable-gdb --with-sysroot --disable-newlib --disable-libgloss --with-system-zlib
make
make install
cd ..

echo "++ build gcc (stage 1)"
mkdir build-gcc-stage1; cd build-gcc-stage1
../gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c --disable-shared --disable-libssp
make
make install
cd ..

echo "++ build newlib"
mkdir build-newlib; cd build-newlib
${NEWLIB_CHECKOUT}/configure --target=or1k-elf --prefix=$PREFIX ${CFLAGS_PARAM}
make
make install
cd ..

echo "++ build gcc (stage 2)"
mkdir build-gcc-stage2; cd build-gcc-stage2
../gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c,c++ --disable-shared --disable-libssp --with-newlib
make
make install
cd ..

echo "++ build gdb"
mkdir build-gdb; cd build-gdb
../gdb/configure --target=or1k-elf --prefix=$PREFIX --enable-shared --disable-itcl --disable-tk --disable-tcl --disable-winsup --disable-gdbtk --disable-libgui --disable-rda --disable-sid --disable-sim --disable-or1ksim --with-sysroot --disable-newlib --disable-libgloss --disable-gas --disable-ld --disable-binutils --disable-gprof --with-system-zlib
make
make install
cd ..
