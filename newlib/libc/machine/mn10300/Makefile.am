## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS) -Wa,--gdwarf-2

noinst_LIBRARIES = lib.a

lib_a_SOURCES = setjmp.S memchr.S memcmp.S memcpy.S memset.S strchr.S \
	strcmp.S strcpy.S strlen.S
lib_a_CFLAGS=$(AM_CFLAGS)
