                .ifndef         __STDLIB_I__
                .set            __STDLIB_I__,   1

                //
                // Standard library macros
                //

                .macro          exit            code
                                mov             x0,    \code
                                bl              _exit
                .endmacro

                .macro          malloc          size
                                mov             x0,    \size
                                bl              _malloc
                .endmacro

                .macro          free            ptr,    size
                                mov             x0,    \ptr
                                mov             x1,    \size
                                bl              _free
                .endmacro

                .endif
