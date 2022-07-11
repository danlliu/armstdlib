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

                function        _strrev
                                // x0 = string to reverse
                                // returns x0 = reversed string
                                pushreg         x0
                                mov             x1,     x0
1:                              ldrb            w2,    [x1]
                                cbz             w2,     2f
                                add             x1,     x1,    #1
                                b               1b
2:                              sub             x1,     x1,    #1
1:                              cmp             x0,     x1
                                b.ge            2f
                                ldrb            w3,    [x0]
                                ldrb            w4,    [x1]
                                strb            w4,    [x0],   #1
                                strb            w3,    [x1],   #-1
                                b               1b
2:                              popreg          x0
                                ret

                function        _strcpy
                                // x0 = destination
                                // x1 = source
                                // returns x0 = destination
                                mov             x2,     x0
1:                              ldrb            w3,    [x1],   #1
                                strb            w3,    [x0],   #1
                                cbnz            w3,     1b
                                mov             x0,     x2
                                ret

                function        _strncpy
                                // x0 = destination
                                // x1 = source
                                // x2 = n
                                // returns x0 = destination
                                mov             x3,     x0
1:                              cbz             x2,     2f
                                sub             x2,     x2,    #1
                                ldrb            w4,    [x1],   #1
                                strb            w4,    [x0],   #1
                                cbnz            w4,     1b
2:                              mov             x0,     x3
                                ret

                function        _strcat
                                // x0 = destination
                                // x1 = source
                                // returns x0 = destination
                                pushpair        lr,     x0
1:                              ldrb            w2,    [x0]
                                cbz             w2,     2f
                                add             x0,     x0,    #1
                                b               1b
2:                              bl              _strcpy
                                poppair         lr,     x0
                                ret

                function        _strncat
                                // x0 = destination
                                // x1 = source
                                // x2 = n
                                // returns x0 = destination
                                pushpair        lr,     x0
1:                              ldrb            w3,    [x0]
                                cbz             w3,     2f
                                add             x0,     x0,    #1
                                b               1b
2:                              bl              _strncpy
                                poppair         lr,     x0
                                ret

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

                function        _strcmp
                                // x0 = string 1
                                // x1 = string 2
                                // returns x0 = strcmp result
1:                              ldrb            w2,    [x0],   #1
                                ldrb            w3,    [x1],   #1
                                cmp             w2,     w3
                                b.ne            2f
                                cbnz            w2,     1b
2:                              sub             x0,     x2,     x3
                                ret

                function        _strncmp
                                // x0 = string 1
                                // x1 = string 2
                                // x2 = n
                                mov             x3,     x4
1:                              cbz             x2,     2f
                                ldrb            w3,    [x0],   #1
                                ldrb            w4,    [x1],   #1
                                cmp             w3,     w4
                                b.ne            2f
                                cbnz            w3,     1b
2:                              sub             x0,     x3,     x4
                                ret

