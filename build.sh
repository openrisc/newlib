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

if [ "x$JOBS" != "x" ]; then
    export JOBS="-j $JOBS"
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

if [ "x$LOG_REDIRECT" != "x" ]; then
    export LOG='> $LOG_REDIRECT'
fi

# Build!
echo "++ build binutils"
mkdir build-binutils; cd build-binutils
eval ../binutils/configure --target=or1k-elf --prefix=$PREFIX --disable-itcl --disable-tk --disable-tcl --disable-winsup --disable-gdbtk --disable-libgui --disable-rda --disable-sid --disable-sim --disable-gdb --with-sysroot --disable-newlib --disable-libgloss --with-system-zlib $LOG
eval make $JOBS $LOG
eval make install $LOG
cd ..

echo "++ build gcc (stage 1)"
mkdir build-gcc-stage1; cd build-gcc-stage1
eval ../gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c --disable-shared --disable-libssp $LOG
eval make $JOBS $LOG
eval make install $LOG
cd ..

echo "++ build newlib"
mkdir build-newlib; cd build-newlib
eval ${NEWLIB_CHECKOUT}/configure --target=or1k-elf --prefix=$PREFIX ${CFLAGS_PARAM} $LOG
eval make $JOBS $LOG
eval make install $LOG
cd ..

echo "++ build gcc (stage 2)"
mkdir build-gcc-stage2; cd build-gcc-stage2
eval ../gcc/configure --target=or1k-elf --prefix=$PREFIX --enable-languages=c,c++ --disable-shared --disable-libssp --with-newlib $LOG
eval make $JOBS $LOG
eval make install $LOG
cd ..

echo "++ build gdb"
mkdir build-gdb; cd build-gdb
eval ../gdb/configure --target=or1k-elf --prefix=$PREFIX --disable-shared --disable-itcl --disable-tk --disable-tcl --disable-winsup --disable-gdbtk --disable-libgui --disable-rda --disable-sid --with-sysroot --disable-newlib --disable-libgloss --disable-gas --disable-ld --disable-binutils --disable-gprof --with-system-zlib $LOG
eval make $JOBS $LOG
eval make install $LOG
cd ..
