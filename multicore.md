---
layout: page
title: Multicore Toolchain
nav_order: 10
---

The OpenRISC architecture supports multicore implementations. The `or1k-elf`
toolchain is a toolchain that can execute code on multiple cores in a symmetric
fashion.

If you build the toolchain manually, you should use a different
prefix, such as `/opt/toolchains/or1k-elf-multicore` and you need
to build newlib with the environment
variable `CFLAGS="-D__OR1K_MULTICORE__"`:

```
../newlib/configure --target=or1k-elf \
	--prefix=$PREFIX \
	CFLAGS_FOR_TARGET="-D__OR1K_MULTICORE__"
```


## Pre-Compiled Toolchain

You can install pre-compiled toolchains and install them on your
Linux system. We have prebuilt-toolchains for releases of the
different components that are preferably installed
to `/opt/toolchains/or1k-elf-multicore` or `/opt/toolchains/or1k-elf`.
You can find some older multicore releases
<a href="https://github.com/openrisc/newlib/releases">here</a>. The last ones being:</p>

 * <a href="https://github.com/openrisc/newlib/releases/download/v2.3.0-1/or1k-elf-multicore_gcc4.9.3_binutils2.26_newlib2.3.0-1_gdb7.11.tgz">GCC 4.9.2, Binutils 2.26, Newlib 2.3.0 (+or1k backports), GDB 7.11
 * <a href="https://github.com/openrisc/newlib/releases/download/v2.3.0-1/or1k-elf-multicore_gcc5.2.0_binutils2.26_newlib2.3.0-1_gdb7.11.tgz">GCC 5.2.0, Binutils 2.26, Newlib 2.3.0 (+or1k backports), GDB 7.11

After downloading a release you can extract it anywhere in your
filesystem, preferable to `/opt/toolchains/or1k-elf/`. You need to add
the toolchain to your path:

```
export PATH=/opt/toolchains/or1k-elf/bin:${PATH}
```


