#include <_ansi.h>

int _kill (int, int) __attribute__((__noreturn__));
void _exit (int);

void
_exit (int status)
{
  /* There is only one SWI for both _exit and _kill. For _exit, call
     the SWI with the second argument set to -1, an invalid value for
     signum, so that the SWI handler can distinguish the two calls.
     Note: The RDI implementation of _kill throws away both its
     arguments.  */
  _kill (status, -1);
}
