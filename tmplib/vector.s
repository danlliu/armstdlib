                //
                // Vector ADT
                //
                // DON'T INCLUDE THIS FILE!!!
                // .include "vector.i"
                //
                // ABI:
                //  x0:             parameter 1 and return value.
                //  x1 - x7:        paramters 2 - 8.
                //  x8 - x15:       caller-save registers.
                //  x16:            syscall register
                //  x19 - x28:      callee-save registers.

                .include    "macros.i"

                .extern     _free
                .extern     _malloc
                .extern     _memcpy

                //  struct Vector
                //      T*  data            0 - 7
                //      int size            8 - 11
                //      int capacity        12 - 15

                .macro  _s_vector_data          xd,     xv
                                ldr            \xd,   [\xv]
                .endmacro

                .macro  _s_vector_size          wd,     xv
                                ldr            \wd,   [\xv,    #8]
                .endmacro

                .macro  _s_vector_cap           wd,     xv
                                ldr            \wd,   [\xv,    #12]
                .endmacro

                function __vector_vector
                                // x0: capacity to allocate
                                // x1: size of each element
                                // Creates an empty vector
                                // returns x0: pointer to the vector
                                pushreg         lr
                                mov             x2,     x0
                                mul             x0,     x0,     x1
                                pushreg         x2
                                bl              _malloc
                                popreg          x2
                                mov             x1,     x0
                                mov             x0,    #16
                                pushpair        x1,     x2
                                bl              _malloc
                                poppair         x1,     x2
                                str             x1,    [x0]
                                str             wzr,   [x0,    #8]
                                str             w2,    [x0,    #12]
                                popreg          lr
                                ret

                function __vector_dtor
                                // x0: pointer to the vector
                                // x1: size of each element
                                // Deallocates the vector and its associated data
                                pushreg         lr
                                mov             x2,     x0
                                _s_vector_data  x0,     x2
                                bl              _free
                                mov             x0,     x2
                                bl              _free
                                popreg          lr
                                ret

                function __vector_at
                                // x0: pointer to the vector
                                // x1: index to access
                                // x2: size of each element
                                // returns x0: pointer to the desired element
                                //
                                // what, C++ has bounds checking?
                                // avoiding undefined behavior is the programmer's responsibility (TM)
                                //
                                _s_vector_data  x0,     x0
                                mul             x1,     x1,     x2
                                add             x0,     x0,     x1
                                ret

                function __vector_front
                                // x0: pointer to the vector
                                // x1: size of each element
                                // returns x0: pointer to the first element
                                // avoiding undefined behavior is the programmer's responsibility (TM)
                                _s_vector_data  x0,     x0
                                ret

                function __vector_back
                                // x0: pointer to the vector
                                // x1: size of each element
                                // returns x0: pointer to the last element
                                // avoiding undefined behavior is the programmer's responsibility (TM)
                                _s_vector_size  w2,     x0
                                _s_vector_data  x0,     x0
                                sub             x2,     x2,    #1
                                mul             x1,     x1,     x2
                                add             x0,     x0,     x1
                                ret

                function __vector_data
                                // x0: pointer to the vector
                                // x1: size of each element
                                _s_vector_data  x0,     x0
                                ret

                function __vector_empty
                                // x0: pointer to the vector
                                // x1: size of each element
                                _s_vector_size  w0,     x0
                                cbz             x0,     1f
                                mov             x0,    #0
                                b               2f
1:                              mov             x0,    #1
2:                              ret

                function __vector_size
                                // x0: pointer to the vector
                                // x1: size of each element
                                _s_vector_size  w0,     x0
                                ret

                function __vector_reserve
                                // x0: pointer to the vector
                                // x1: capacity to reserve
                                // x2: size of each element
                                pushreg         lr
                                str             w1,    [x0,    #12]
                                mov             x3,     x0
                                mul             x0,     x1,     x2
                                pushpair        x2,     x3
                                bl              _malloc
                                poppair         x2,     x3
                                _s_vector_data  x1,     x3
                                str             x0,    [x3]
                                _s_vector_size  w3,     x3
                                mul             x2,     x2,     x3
                                pushpair        x1,     x2
                                bl              _memcpy
                                poppair         x1,     x2
                                mov             x0,     x1
                                mov             x1,     x2
                                bl              _free
                                popreg          lr
                                ret

                function __vector_capacity
                                // x0: pointer to the vector
                                // x1: size of each element
                                _s_vector_cap   w0,     x0
                                ret

                function __vector_shrink_to_fit
                                // x0: pointer to the vector
                                // x1: size of each element
                                pushreg         lr
                                mov             x2,     x1
                                _s_vector_size  w1,     x0
                                bl              __vector_reserve
                                popreg          lr
                                ret

                function __vector_clear
                                // x0: pointer to the vector
                                // x1: size of each element
                                str             wzr,   [x0,    #8]
                                ret

                function __vector_push_back
                                // x0: pointer to the vector
                                // x1: pointer to new element
                                // x2: size of each element
                                pushreg         lr

                                _s_vector_size  w3,     x0
                                _s_vector_cap   w4,     x0
                                cmp             w3,     w4
                                b.lt            1f

                                pushreg         x0
                                pushpair        x1,     x2
                                lsl             x1,     x4,    #1
                                bl              __vector_reserve
                                poppair         x1,     x2
                                popreg          x0

1:                              _s_vector_size  w3,     x0
                                add             w3,     w3,    #1
                                str             w3,    [x0,    #8]

                                pushpair        x1,     x2
                                mov             x1,     x2
                                bl              __vector_back
                                poppair         x1,     x2
                                bl              _memcpy

                                popreg          lr
                                ret

                function __vector_pop_back
                                // x0: pointer to the vector
                                // x1: size of each element
                                _s_vector_size  w2,     x0
                                sub             w2,     w2,    #1
                                str             w2,    [x0,    #8]
                                ret

