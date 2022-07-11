
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
                                exit           #1

                .data

helloworld:     .ascii          "Hello, world!\n\0"

