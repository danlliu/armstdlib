
                //
                // Test template
                //

                .global         _start
                .align          2

                .include        "asm.i"
                .include        "macros.i"
                .include        "stdlib.i"
                .include        "stdio.i"
                .include        "string.i"

                .text

                main
                                labeladdr       x19,    hello
                                labeladdr       x20,    hello2
                                labeladdr       x21,    jello
                                labeladdr       x22,    jelly
                                labeladdr       x23,    correct

                                strcmp          x19,    x19
                                cbnz            x0,     1f                                      // should not take

                                mov             x0,    #0x31
                                strb            w0,    [x23]
                                puts            x23
1:
                                strcmp          x19,    x20
                                cbnz            x0,     1f                                      // should not take

                                mov             x0,    #0x32
                                strb            w0,    [x23]
                                puts            x23
1:
                                strcmp          x19,    x21
                                cmp             x0,     xzr
                                b.ge            1f                                              // should not take

                                mov             x0,    #0x33
                                strb            w0,    [x23]
                                puts            x23
1:
                                strcmp          x21,    x19
                                cmp             x0,     xzr
                                b.le            1f                                              // should not take

                                mov             x0,    #0x34
                                strb            w0,    [x23]
                                puts            x23
1:
                                strcmp          x21,    x22
                                cmp             x0,     xzr
                                b.ge            1f                                              // should not take

                                mov             x0,    #0x35
                                strb            w0,    [x23]
                                puts            x23
1:

                                exit           #0

                .data

hello:          .asciz          "Hello"
hello2:         .asciz          "Hello"
jello:          .asciz          "Jello"
jelly:          .asciz          "Jelly"
correct:        .asciz          "1 correct!\n"

