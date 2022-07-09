                //
                // Standard library functions
                //
                // DON'T INCLUDE THIS FILE!
                // .include "stdlib.i"
                // Trust me, it'll make your life easier
                //
                // ABI:
                //  x0:         parameter 1 and return value.
                //  x1 - x7:    paramters 2 - 8.
                //  x8 - x15:   caller-save registers.
                //  x16:        syscall register
                //  x19 - x28:  callee-save registers.

                .include        "macros.i"

                function        _exit
                                // x0 = exit code
                                mov             x16,   #1
                                svc            #0x80
                                ret

