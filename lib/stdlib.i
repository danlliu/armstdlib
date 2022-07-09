                .ifndef         __STRING_I__
                .set            __STRING_I__,   1

                //
                // Standard library macros
                //

                .macro          exit            code
                                mov             x0,    \code
                                bl              _exit
                .endmacro

                .endif
