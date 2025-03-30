---
layout: page
title: or1k-elf Toolchain Build Instructions
nav_order: 2
---

If you can't run one of the prebuilt toolchains on your system or want to do a
development build, you can build the toolchain from scratch. This is not that
spectacular nowadays and can take up to an hour at maximum. Nevertheless you
need some basic understanding of how a build GNU process works.

### Preparation

First of all you need the development packages of
the `mpfr`, `gmp`, `mpc` and `zlib`
libraries on your computer, along with of course the basic GCC
toolchain for your host. On a recent Debian/Ubuntu this is done
with:

```
$ sudo apt-get install git libgmp-dev libmpfr-dev libmpc-dev \
    zlib1g-dev texinfo build-essential flex bison
```

Next you need to setup the environment for your build
(`PREFIX` to ease the execution of the code below
and `PATH` because later stages need the results from previous
stages):

```bash
export PREFIX=/opt/toolchains/or1k-elf
export PATH=$PATH:$PREFIX/bin
```

Next you need the git repositories. Of course you can also use the
release snapshot tarballs of the releases. To build from the upstream
repositories:

```
git clone git://gcc.gnu.org/git/gcc.git gcc
git clone git://sourceware.org/git/binutils-gdb.git binutils-gdb
git clone git://sourceware.org/git/newlib-cygwin.git newlib
```

In case you want to build from the OpenRISC development sources you can
checkout our repositories from github, but add them as remotes
to the upstream repositories like this:

```
# Add openrisc upstream remote to repos
git -C binutils-gdb remote add openrisc https://github.com/openrisc/binutils-gdb.git
git -C bintuils-gdb fetch openrisc
git -C gcc          remote add openrisc https://github.com/openrisc/or1k-gcc.git
git -C gcc          fetch openrisc
git -C newlib       remote add openrisc https://github.com/openrisc/newlib.git
git -C newlib       fetch openrisc
```

The OpenRISC repositories differ from the upstream repositories in that
there might be changes in the upstream code that have not yet been
merged.  Also, there may be architecture specific code that is not yet in the
upstream distribution.

Of course you may desire to check out a repository for a certain
release by checkout of the respective git tag. Once the repositories
are in your temporary compilation repository, you need to execute the
following sequence to build the entire toolchain.

*Note:* In case you want to copy the toolchain to other
computers with a different distribution or want to build a release
version, it is preferable not to dynamically link gcc against the
installed versions of `libgmp`, `libmpfr` and `libmpc`. Instead you
then extract the sources of the libraries into the gcc source
tree. The build will then pick those sources up and compile them into
gcc. For example:

```
wget https://gmplib.org/download/gmp/gmp-6.1.0.tar.xz
tar -xf gmp-6.1.0.tar.xz
ln -s ../gmp-6.1.0 gcc/gmp
wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
tar -xzf mpc-1.0.3.tar.gz
ln -s ../mpc-1.0.3 gcc/mpc
wget http://www.mpfr.org/mpfr-current/mpfr-3.1.6.tar.xz
tar -xf mpfr-3.1.6.tar.xz
ln -s ../mpfr-3.1.6 gcc/mpfr
```

### Build binutils

The GNU binutils contain the assembler, linker, `objdump`
and a lot more programs to handle the binary files for a certain
architecture. Those can be directly built standalone:

```
mkdir build-binutils; cd build-binutils
../binutils-gdb/configure --target=or1k-elf \
    --prefix=$PREFIX \
    --disable-itcl \
    --disable-tk \
    --disable-tcl \
    --disable-winsup \
    --disable-gdbtk \
    --disable-libgui \
    --disable-rda \
    --disable-sid \
    --disable-sim \
    --disable-gdb \
    --with-sysroot \
    --disable-newlib \
    --disable-libgloss \
    --with-system-zlib
make
make install
cd ..
```

### GCC stage 1

GCC is built in two stages. First we need a basic C compiler
to build the C library in the next step:

```
mkdir build-gcc-stage1; cd build-gcc-stage1
../gcc/configure --target=or1k-elf \
    --prefix=$PREFIX \
    --enable-languages=c \
    --disable-shared \
    --disable-libssp
make
make install
cd ..
```

### Newlib

Now we can build the newlib C library:

```
mkdir build-newlib; cd build-newlib
../newlib/configure --target=or1k-elf --prefix=$PREFIX
make
make install
cd ..
```

### GCC stage 2

Now we can build the entire GCC and tell it about using newlib:

```
mkdir build-gcc-stage2; cd build-gcc-stage2
../gcc/configure --target=or1k-elf \
    --prefix=$PREFIX \
    --enable-languages=c,c++ \
    --disable-shared \
    --disable-libssp \
    --with-newlib
make
make install
cd ..
```

### GDB

In the last step, we can now build `gdb` for our
architecture:

```
mkdir build-gdb; cd build-gdb
../binutils-gdb/configure --target=or1k-elf \
    --prefix=$PREFIX \
    --disable-itcl \
    --disable-tk \
    --disable-tcl \
    --disable-winsup \
    --disable-gdbtk \
    --disable-libgui \
    --disable-rda \
    --disable-sid \
    --with-sysroot \
    --disable-newlib \
    --disable-libgloss \
    --disable-gas \
    --disable-ld \
    --disable-binutils \
    --disable-gprof \
    --with-system-zlib
make
make install
cd ..
```

Now you are done and have the
binaries `or1k-elf-gcc`, `or1k-elf-gdb`, `or1k-elf-ld`
etc. in `$PREFIX/bin`.
