
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
                                labeladdr       x19,    jelloworld
                                labeladdr       x20,    helloworld
                                strcpy          x19,    x20
                                mov             x21,   #74                                      // 'J'
                                strb            w21,   [x19]
                                puts            x20
                                puts            x19
                                exit           #0

                .data

helloworld:     .ascii          "Hello, world!\n\0"
jelloworld:     .space          16

