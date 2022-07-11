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

                function        _int2str
                                // x0 = integer to convert
                                // x1 = string buffer to write to
                                // returns x0 = original string buffer
                                pushpair        lr,     x1
                                cmp             x0,    #0
                                b.ge            1f
                                mov             x2,    #45                                      // '-'
                                strb            w2,    [x1],   #1
                                sub             x0,     xzr,    x0
1:                              pushreg         x1
1:                              movz            x2,    #0x3334                                  // 2^29 / 10
                                movk            x2,    #0x333,  LSL    #16
                                mul             x2,     x0,     x2
                                lsr             x2,     x2,    #29                              // x0 / 10
                                mov             x3,    #10
                                mul             x3,     x2,     x3
                                sub             x3,     x0,     x3                              // x0 % 10
                                add             x3,     x3,    #48                              // '0'
                                strb            w3,    [x1],   #1
                                mov             x0,     x2                                      // x0 = x0 / 10
                                cbnz            x0,     1b
                                popreg          x0
                                bl              _strrev
                                poppair         lr,     x0
                                ret


