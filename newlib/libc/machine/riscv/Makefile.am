## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS)

noinst_LIBRARIES = lib.a

lib_a_SOURCES = memmove.S memmove-stub.c memset.S memcpy-asm.S memcpy.c strlen.c \
	strcpy.c strcmp.S setjmp.S ieeefp.c ffs.c
lib_a_CFLAGS=$(AM_CFLAGS)
