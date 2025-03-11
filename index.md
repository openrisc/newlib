---
layout: home
title: Home
nav_order: 1
---

The `or1k-elf` toolchain is a baremetal compiler, assembler, etc.
toolchain for the <a href="https://openrisc.io/">OpenRISC</a>
architecture. The toolchain is based on
the <a href="https://sourceware.org/newlib/">newlib</a> C library and
the standard GNU gcc, binutils and gdb. With this toolchain you can
compile your own C code and execute it on the various OpenRISC
targets.

# Build your software

A simple *hello world* program like this `hello.c`

```c
#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("Hello World!\n");
    return 0;
}
```

is compiled with the cross compilation toolchain:

```
$ or1k-elf-gcc -o hello.elf hello.c
```

The default is to build for the `or1ksim` simulator. You can also build
it for other boards, e.g. for the DE0 nano:

```
$ or1k-elf-gcc -o hello.elf hello.c -mboard=de0_nano
```

There are a few architecture-specific compiler options, see the full
list with `or1k-elf-gcc --target-help`:

 * `-msoft-float` compiles with soft floating point instructions, for example
   when your target implementation does not contain an FPU.
 * `-msoft-div` compiles with software emulation of divide operations
 * `-msoft-mul` compiles with software emulation of multiply operations

### or1k support extensions<

The `libgloss`, which is an essential part of a newlib-based
cross-compiler contains some additional code to support baremetal
programming. Most essential those are some simple helping functions to
change the core state and support for exception, interrupt and timer
handling. An extensive documentation of the functions can be found <a href="docs/html/index.html">here</a>.

There also is a <a href="tutorial.html">short tutorial</a> with
some basic examples is also available

### Download and Install the Toolchain

You can install pre-compiled toolchains and install them on your
Linux system. We have prebuilt-toolchains for releases of the
different components that are preferably installed
to `/opt/toolchains/or1k-elf`. You can find releases in the following locations:

 * [openrisc/newlib/releases](https://github.com/openrisc/newlib/releases) Older
   releases from the OpenRISC community last published in May 2016. Used the
   old non-upstreamed gcc port.
 * [Embecosm OpenRISC toolchain top-of-tree](https://embecosm.com/downloads/tool-chain-downloads/#openrisc-top-of-tree-compilers) Embecosm
   produced toolchain builds up until 2023.  Unforthunately this effort stopped.
 * [openrisc/or1k-gcc/releases](https://github.com/openrisc/or1k-gcc/releases) The latest releases from OpenRISC.

After downloading a release you can extract it anywhere in your
filesystem, we recommend to `/opt/toolchains/or1k-elf/`. You need to add
the toolchain to your path:

```
export PATH=/opt/toolchains/or1k-elf/bin:${PATH}
```

### Development Build status

Whenever something is pushed to the newlib repository, the current
development versions of Binutils, GCC, (or1k) Newlib and GDB are
automatically build
at <a href="https://travis-ci.org/openrisc/newlib">Travis CI</a>.

Current build
status: <a href="https://travis-ci.org/openrisc/newlib"><img src="https://travis-ci.org/openrisc/newlib.svg?branch=or1k"></a>
