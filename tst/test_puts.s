
                //
                // Test template
                //

                .global         _start
                .align          2

                .include        "asm.i"
                .include        "macros.i"
                .include        "stdlib.i"
                .include        "stdio.i"

                .text

                main
                                labeladdr       x0,     helloworld
                                puts            x0
                                exit            0

                .data

helloworld:     .ascii          "Hello, world!\n\0"

