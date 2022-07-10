
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
                                labeladdr       x20,    world
                                strcat          x19,    x20
                                puts            x19
                                exit           #0

                .data

hello:          .ascii          "Hello, \0\0\0\0\0\0\0\0\0"
world:          .ascii          "world!\n\0"

