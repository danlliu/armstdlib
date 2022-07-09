                .ifndef         __MACROS_S__
                .set            __MACROS_S__,   1

                //
                // Convenience macros
                //

                .macro          labeladdr       xd,     label
                                adrp           \xd,    \label@PAGE
                                add            \xd,    \xd,    \label@PAGEOFF
                .endmacro

                .macro          function        label
                                .align          4
                                .global        \label
\label:
                .endmacro

                .macro          pushreg         xn
                                str            \xn,    [sp,    #-16]!
                .endmacro

                .macro          pushpair        xn,     xm
                                stp            \xn,    \xm,    [sp,    #-16]!
                .endmacro

                .macro          popreg          xn
                                ldr            \xn,    [sp],   #16
                .endmacro

                .macro          poppair         xn,     xm
                                ldp            \xn,    \xm,    [sp],   #16
                .endmacro

                .endif
