## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS)

noinst_LIBRARIES = lib.a

lib_a_SOURCES = ioctl.S isatty.S read.S lseek.S close.S sbrk.S fstat.S \
	cerror.S exit.S write.S sysv60.S fpx.c fps.S open.S
lib_a_CFLAGS = $(AM_CFLAGS)

all-local: crt0.o
