## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS)

noinst_LIBRARIES = lib.a

lib_a_SOURCES = syscalls.c _exit.S sbrk.c misc.c crt1.c \
	close.S fstat.S lseek.S open.S read.S stat.S write.S
lib_a_CFLAGS = $(AM_CFLAGS)

all-local: crt0.o
