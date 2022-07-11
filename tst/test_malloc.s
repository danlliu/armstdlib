
                //
                // Test template
                //

                .global         _start
                .align          2

                .include        "asm.i"
                .include        "macros.i"
                .include        "stdlib.i"

                .text

                main
                                malloc         #16
                                free            x0,    #16
                                exit           #0

                .data

helloworld:     .ascii          "Hello, world!\n\0"

