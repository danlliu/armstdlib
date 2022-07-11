
                //
                // Test template
                //

                .global         _start
                .align          2

                .include        "asm.i"
                .include        "macros.i"
                .include        "fmt.i"
                .include        "stdlib.i"
                .include        "stdio.i"

                .text

                main
                                labeladdr       x19,    buffer
                                int2str        #0,      x19
                                puts            x0

                                labeladdr       x20,    newline
                                puts            x20

                                int2str        #-1234,  x19
                                puts            x0
                                puts            x20

                                int2str        #12345,  x19
                                puts            x0
                                puts            x20

                                exit           #0

                .data

buffer:         .space          16
newline:        .asciz          "\n"

