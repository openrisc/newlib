## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS)

noinst_LIBRARIES = lib.a

lib_a_SOURCES = udivhi3.S umodhi3.S smulhi3.S lshrhi.S sdivhi3.S mulsi3.c \
	divsi3.c cmpsi.c
lib_a_CFLAGS = $(AM_CFLAGS)
