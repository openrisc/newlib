## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

GENERAL_SOURCES = \
	getcwd.c 	\
	pread.c 	\
	pwrite.c 	\
	sigset.c

## Distinguish different EL/IX level interfaces
ELIX_2_SOURCES = \
	ttyname.c \
	ttyname_r.c

ELIX_4_SOURCES = \
	basename.c	\
	dirname.c	\
	getlogin.c	\
	getpass.c 	\
	getpwent.c 	\
	getut.c

if ELIX_LEVEL_1
ELIX_SOURCES =
else
if ELIX_LEVEL_2
ELIX_SOURCES = $(ELIX_2_SOURCES)
else
if ELIX_LEVEL_3
ELIX_SOURCES = $(ELIX_2_SOURCES)
else
ELIX_SOURCES = $(ELIX_2_SOURCES) $(ELIX_4_SOURCES)
endif
endif
endif

noinst_LIBRARIES = lib.a
lib_a_SOURCES = $(GENERAL_SOURCES) $(ELIX_SOURCES)
lib_a_CFLAGS = $(AM_CFLAGS)
