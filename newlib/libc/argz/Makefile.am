## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

## All functions in this directory are EL/IX level 2 and above
if ELIX_LEVEL_1
ELIX_SOURCES =
else
ELIX_SOURCES = 		\
	argz_add.c 	\
	argz_add_sep.c 	\
	argz_append.c 	\
	argz_count.c 	\
	argz_create.c 	\
	argz_create_sep.c \
	argz_delete.c 	\
	argz_extract.c 	\
	argz_insert.c 	\
	argz_next.c 	\
	argz_replace.c 	\
	argz_stringify.c \
	buf_findstr.c 	\
	envz_entry.c 	\
	envz_get.c 	\
	envz_add.c 	\
	envz_remove.c 	\
	envz_merge.c 	\
	envz_strip.c
endif

noinst_LIBRARIES = lib.a
lib_a_SOURCES = dummy.c $(ELIX_SOURCES)
lib_a_CFLAGS = $(AM_CFLAGS)
