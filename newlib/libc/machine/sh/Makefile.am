## Process this file with automake to generate Makefile.in

AM_CPPFLAGS = $(NEWLIB_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(AM_CPPFLAGS)

noinst_LIBRARIES = lib.a

if SH64
lib_a_SOURCES = memcpy.S memset.S setjmp.S strcpy.S strlen.S strcmp.S strncpy.S
else
lib_a_SOURCES = memcpy.S memset.S setjmp.S strcpy.S strlen.S strcmp.S
endif

lib_a_CFLAGS=$(AM_CFLAGS)

$(lpfx)memcpy.o: asm.h
$(lpfx)memset.o: asm.h
$(lpfx)setjmp.o: asm.h
$(lpfx)strcpy.o: asm.h
$(lpfx)strcmp.o: asm.h
$(lpfx)strncpy.o: asm.h
