## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS) $(CFLAGS)

noinst_LIBRARIES = lib.a

lib_a_SOURCES = close.c fstat.c isatty.c lseek.c read.c write.c \
                fcntl.c getpid.c kill.c open.c raise.c stat.c unlink.c
lib_a_CFLAGS = $(AM_CFLAGS)
