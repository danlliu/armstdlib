                .ifndef         __STRING_I__
                .set            __STRING_I__,   1

                //
                // String function macros
                //

                .macro          strlen          string
                                mov             x0,    \string
                                bl              _strlen
                .endmacro

                .endif
