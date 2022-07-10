
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
                                labeladdr       x19,    helloworld
                                labeladdr       x20,    hello
                                strncat         x19,    x20,   #5
                                puts            x19
                                exit           #0

                .data

helloworld:     .ascii          "\0\0\0\0\0, world!\n\0"
hello:          .ascii          "Hello\0"

