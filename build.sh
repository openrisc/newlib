#!/bin/bash -e

if [ "x$PREFIX" == "x" ]; then
    export PREFIX=/opt/toolchains/or1k-elf
fi

export PATH=$PATH:$PREFIX/bin

if [ "x$LOG" == "x" ]; then
    export LOG=build.log
fi

if [ "x$BUILD_MULTICORE" == "x" ]; then
    export CFLAGS_PARAM=""
else
    export CFLAGS_PARAM="CFLAGS=-D__OR1K_MULTICORE__"
fi

if [ "x$NEWLIB_CHECKOUT" == "x" ]; then
    git clone git://sourceware.org/git/newlib-cygwin.git newlib
    export NEWLIB_CHECKOUT=$PWD/newlib
fi


git clone git://sourceware.org/git/binutils-gdb.git
git clone https://github.com/openrisc/or1k-gcc.git gcc

echo "++ build binutils"
mkdir build-binutils; cd build-binutils
../binutils-gdb/configure --target=or1k-elf --prefix=$PREFIX --enable-shared --disable-itcl --disable-tk --disable-tcl --disable-winsup --disable-gdbtk --disable-libgui --disable-rda --disable-sid --disable-sim --disable-gdb --with-sysroot --disable-newlib --disable-libgloss --with-system-zlib > $LOG
make > $LOG
make install > $LOG
cd ..

echo "++ build gcc (stage 1)"
mkdir build-gcc-stage1; cd build-gcc-stage1
../gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c --disable-shared --disable-libssp > $LOG
make > $LOG
make install > $LOG
cd ..

echo "++ build newlib"
mkdir build-newlib; cd build-newlib
${NEWLIB_CHECKOUT}/configure --target=or1k-elf --prefix=$PREFIX ${CFLAGS_PARAM} > $LOG
make > $LOG
make install > $LOG
cd ..

echo "++ build gcc (stage 2)"
mkdir build-gcc-stage2; cd build-gcc-stage2
../gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c,c++ --disable-shared --disable-libssp --with-newlib > $LOG
make > $LOG
make install > $LOG
cd ..
