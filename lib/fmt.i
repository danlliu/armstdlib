                .ifndef         __STRING_I__
                .set            __STRING_I__,   1

                //
                // Formatting macros
                //

                .macro          int2str         n,      buf
                                mov             x0,    \n
                                mov             x1,    \buf
                                bl              _int2str
                .endmacro

                .endif
