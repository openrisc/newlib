## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS)

noinst_LIBRARIES = lib.a

lib_a_SOURCES = \
	memchr.S memcmp.S memcpy.S memset.S setjmp.S strcat.S strcmp.S \
	strcpy.S strlen.S strncat.S strncmp.S strncpy.S
lib_a_CFLAGS=$(AM_CFLAGS)
