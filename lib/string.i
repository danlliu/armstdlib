                .ifndef         __STRING_I__
                .set            __STRING_I__,   1

                //
                // String function macros
                //

                .macro          strcpy          dest,   src
                                mov             x0,    \dest
                                mov             x1,    \src
                                bl              _strcpy
                .endmacro

                .macro          strlen          string
                                mov             x0,    \string
                                bl              _strlen
                .endmacro

                .endif
