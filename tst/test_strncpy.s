
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
                                strncpy         x19,    x20,   #5
                                puts            x19
                                labeladdr       x19,    newline
                                puts            x19
                                exit           #0

                .data

helloworld:     .ascii          "Hello, world!\n\0"
jelloworld:     .space          16
newline:        .asciz          "\n"

