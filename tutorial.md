---
layout: page
title: Tutorial of the or1k Support Functions
nav_order: 3
---

The or1k-elf toolchain contains the standard C library
(`printf`, `malloc`, etc.). But beside this, it also
contains a large set of function that help the baremetal programmer
with controlling the processor, shortly summarized
as `or1k-support`.

### Getting Started

The most important functions are defined in
the `or1k-support.h` header file. For example, three macros are
defined there to access memory-mapped
registers: `REG8(x)`, `REG16(x)` and `REG32(x)`.
Those are for example helpful if you control a device that is
connected to the bus and the compiler should not reuse previously
loaded values (the macros expand to pointers to volatile values).

Example:

```c
#include <or1k-support.h>
...
#define MY_DEVICE_READ_REG 0xf0000000
...
void getchars(char* x, int num) {
    int i;
    for (i = 0; i < num; i++) {
	x[i] = REG8(MY_DEVICE_READ_REG);
    }
}
```

### Cache handling

The caches can be controlled by a set
of <a href="docs/html/group__or1k__cache.html">functions</a>. To
disable the data cache for a certain period of time, then flush this
value from the cache and re-activate the cache (for non-coherent
memory accesses), you can for example execute:

```c
#include <or1k-support.h>
...
void f(int *a) {
    or1k_dcache_disable();
    ...
    /* your fancy non-coherent stuff via a */
    ...
    or1k_dcache_flush(a);
    ...
    or1k_dcache_enable();
}
```
