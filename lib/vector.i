                .ifndef __VECTOR_I__
                .set __VECTOR_I__, 1

                //
                // Vector ADT
                //
                // .include "vector.i"
                //
                // ABI:
                //  x0:             parameter 1 and return value.
                //  x1 - x7:        paramters 2 - 8.
                //  x8 - x15:       caller-save registers.
                //  x16:            syscall register
                //  x19 - x28:      callee-save registers.

                //  Available methods
                //  + vector_vector<Tsize>(capacity) -> vector*
                //  + vector_dtor<Tsize>(vector*)
                //
                //  + vector_at<Tsize>(vector*, int) -> T*
                //  + vector_front<Tsize>(vector*) -> T*
                //  + vector_back<Tsize>(vector*) -> T*
                //  + vector_data<Tsize>(vector*) -> T*
                //
                //  + vector_empty<Tsize>(vector*) -> int
                //  + vector_size<Tsize>(vector*) -> int
                //  + vector_reserve<Tsize>(vector*, int)
                //  + vector_capacity<Tsize>(vector*) -> int
                //  + vector_shrink_to_fit<Tsize>(vector*)
                //
                //  + vector_clear<Tsize>(vector*)
                //  + vector_push_back<Tsize>(vector*, T*)
                //  + vector_pop_back<Tsize>(vector*)

                .macro          vector_vector   capacity,   Tsize,  size
                                // x0: capacity to allocate
                                // returns x0: new vector
                                mov             x0,    \capacity
                                mov             x1,    \size
                                bl              __vector_vector
                .endmacro

                .macro          vector_dtor     Tsize,  size
                                // x0: vector to destroy
                                mov             x1,    \size
                                bl              __vector_dtor
                .endmacro

                .macro          vector_at       Tsize,  size
                                // x0: vector
                                // x1: index
                                mov             x2,    \size
                                bl              __vector_at
                .endmacro

                .macro          vector_front    Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_front
                .endmacro

                .macro          vector_back     Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_back
                .endmacro

                .macro          vector_data     Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_data
                .endmacro

                .macro          vector_empty    Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_empty
                .endmacro

                .macro          vector_size     Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_size
                .endmacro

                .macro          vector_reserve  Tsize,  size
                                // x0: vector
                                // x1: capacity to reserve
                                mov             x2,    \size
                                bl              __vector_size
                .endmacro

                .macro          vector_capacity         Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_capacity
                .endmacro

                .macro          vector_shrink_to_fit   Tsize
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_shrink_to_fit
                .endmacro

                .macro          vector_clear    Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_clear
                .endmacro

                .macro          vector_push_back        Tsize,  size
                                // x0: vector
                                // x1: pointer to new element
                                mov             x2,    \size
                                bl              __vector_push_back
                .endmacro

                .macro          vector_pop_back         Tsize,  size
                                // x0: vector
                                mov             x1,    \size
                                bl              __vector_pop_back
                .endmacro

                .endif
