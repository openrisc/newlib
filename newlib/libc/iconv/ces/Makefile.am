## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

GENERAL_SOURCES = \
	utf-8.c \
	utf-16.c \
	ucs-2.c \
	us-ascii.c \
	ucs-4.c \
	ucs-2-internal.c \
	ucs-4-internal.c \
	cesbi.c \
	table.c \
	table-pcs.c \
	euc.c

## The following interfaces are EL/IX level 2
if ELIX_LEVEL_1
ELIX_SOURCES = \
	utf-8.c \
	utf-16.c \
	ucs-2.c \
	us-ascii.c \
	ucs-4.c \
	ucs-2-internal.c \
	ucs-4-internal.c \
	cesbi.c \
	table.c \
	table-pcs.c \
	euc.c
else
ELIX_SOURCES = 
endif

noinst_LIBRARIES = lib.a
lib_a_SOURCES = $(GENERAL_SOURCES) $(ELIX_SOURCES)
lib_a_CFLAGS = $(AM_CFLAGS)
