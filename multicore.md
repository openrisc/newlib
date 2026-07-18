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
../newlib/configure --target=or1k-nonemc-elf \
	--prefix=$PREFIX \
	CFLAGS_FOR_TARGET="-D__OR1K_MULTICORE__"
```


## Pre-Compiled Toolchain

You can install pre-compiled toolchains and install them on your
Linux system. We have prebuilt-toolchains
available from the OpenRISC [toolchain releases](https://github.com/stffrdhrn/or1k-toolchain-build/releases)
repo.

After downloading a release you can extract it anywhere in your
filesystem, preferable to `/opt/toolchains/or1k-nonemc-elf/`. After extracing add
the toolchain to your path:

```
export PATH=/opt/toolchains/or1k-nonemc-elf/bin:${PATH}
```


