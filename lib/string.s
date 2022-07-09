                //
                // String functions
                //
                // DON'T INCLUDE THIS FILE!
                // .include "string.i"
                // Trust me, it'll make your life easier
                //
                // ABI:
                //  x0:         parameter 1 and return value.
                //  x1 - x7:    paramters 2 - 8.
                //  x8 - x15:   caller-save registers.
                //  x16:        syscall register
                //  x19 - x28:  callee-save registers.

                .include        "macros.i"

                function        _strlen
                                // x0 = C string to find length of
                                // returns x0 = length of string
                                mov             x2,    #0
1:                              ldrb            w1,    [x0],   #1
                                cbz             w1,     2f
                                add             x2,     x2,    #1
                                b               1b
2:                              mov             x0,     x2
                                ret

