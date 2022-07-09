                //
                // Standard library functions
                //
                // DON'T INCLUDE THIS FILE!
                // .include "stdio.i"
                // Trust me, it'll make your life easier
                //
                // ABI:
                //  x0:         parameter 1 and return value.
                //  x1 - x7:    paramters 2 - 8.
                //  x8 - x15:   caller-save registers.
                //  x16:        syscall register
                //  x19 - x28:  callee-save registers.

                .include        "macros.i"
                .include        "string.i"

                function        _fputs
                                // x0 = C string to write
                                // x1 = file descriptor to write to
                                pushreg         lr
                                pushpair        x0,     x1
                                strlen          x0
                                mov             x2,     x0
                                poppair         x1,     x0
                                mov             x16,   #4                                       // write
                                svc            #0x80
                                popreg          lr
                                ret

