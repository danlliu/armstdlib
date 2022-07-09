                .ifndef         __STDIO_I__
                .set            __STDIO_I__,   1

                //
                // I/O function macros
                //

                .macro          fputs           str,    fd
                                mov             x0,    \str
                                mov             x1,    \fd
                                bl              _fputs
                .endmacro

                .macro          puts            str
                                mov             x0,    \str
                                mov             x1,    #1
                                bl              _fputs
                .endmacro

                .endif
