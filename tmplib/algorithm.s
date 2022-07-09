                //
                // Algorithms because why not
                //
                // ABI:
                //  x0:         parameter 1 and return value.
                //  x1 - x7:    paramters 2 - 8.
                //  x8 - x15:   caller-save registers.
                //  x16:        syscall register
                //  x19 - x28:  callee-save registers.

                .include        "macros.i"

                // Helper macros for quicksort

                .macro          ldsize          xd,     wd,     xn,     xs
                                // xs keeps track of the shift amount
                                cmp            \xs,    #0
                                b.eq            11f
                                cmp            \xs,    #1
                                b.eq            12f
                                cmp            \xs,    #2
                                b.eq            14f
                                cmp            \xs,    #3
                                b.eq            18f
11:                             ldrb           \wd,   [\xn]
                                b               11f
12:                             ldrh           \wd,   [\xn]
                                b               11f
14:                             ldr            \wd,   [\xn]
                                b               11f
18:                             ldr            \xd,   [\xn]
                                b               11f
11:
                .endmacro

                .macro          stsize          xd,     wd,     xn,     xs
                                // xs keeps track of the shift amount
                                cmp            \xs,    #0
                                b.eq            11f
                                cmp            \xs,    #1
                                b.eq            12f
                                cmp            \xs,    #2
                                b.eq            14f
                                cmp            \xs,    #3
                                b.eq            18f
11:                             strb           \wd,  [\xn]
                                b               11f
12:                             strh           \wd,  [\xn]
                                b               11f
14:                             str            \wd,  [\xn]
                                b               11f
18:                             str            \xd,  [\xn]
                                b               11f
11:
                .endmacro

                .text

                function        _quicksort
                                // x0: pointer to array to sort
                                // x1: length of array (in elements)
                                // x2: size of array elements (1, 2, 4, or 8)
                                // performs in-place quicksort
                                // returns x0: pointer to original array

                                cmp             x1,    #1
                                b.gt            1f
                                ret

                                // Step 1: persist registers
                  1:            pushreg         lr

                                // Step 2: get shift amount
                                cmp             x2,    #1
                                b.eq            1f
                                cmp             x2,    #2
                                b.eq            2f
                                cmp             x2,    #4
                                b.eq            4f
                  1:            mov             x2,    #0
                                b               1f
                  2:            mov             x2,    #1
                                b               1f
                  4:            mov             x2,    #2
                                b               1f
                  8:            mov             x2,    #3
                                b               1f
                  1:            nop

                                // Step 3: partition
                                // x3: pivot addr -> pivot
                                // lsr     x3,     x1,    #1
                                // lsl     x3,     x3,     x2
                                // add     x3,     x0,     x3
                                mov             x3,     x0
                                ldsize          x3,     w3,     x3,     x2

                                // Left and right indices (x4, x5)
                                mov             x4,     x0                      // i
                                mov             x5,     x0                      // j
                                lsl             x6,     x1,     x2              // k
                                add             x6,     x0,     x6
                                mov             x7,    #1
                                lsl             x7,     x7,     x2
                                sub             x6,     x6,     x7

                                // Step 4: partition nodes
                                // Dutch National Flag partition
                  1:            cmp             x5,     x6
                                b.gt            4f
                                ldsize          x7,     w7,     x5,     x2      // A[j]
                                cmp             x7,     x3
                                b.gt            2f
                                b.eq            3f
                                // x7 < x3
                                ldsize          x8,     w8,     x4,     x2      // A[i]
                                stsize          x7,     w7,     x4,     x2      // swap A[i], A[j]
                                stsize          x8,     w8,     x5,     x2
                                mov             x7,    #1
                                lsl             x7,     x7,     x2
                                add             x4,     x4,     x7              // i++
                                add             x5,     x5,     x7              // j++
                                b               1b
                  2:            ldsize          x8,     w8,     x6,     x2      // A[k]
                                stsize          x7,     w7,     x6,     x2      // swap A[j], A[k]
                                stsize          x8,     w8,     x5,     x2
                                mov             x7,    #1
                                lsl             x7,     x7,     x2
                                sub             x6,     x6,     x7              // k--
                                b               1b
                  3:            mov             x7,    #1
                                lsl             x7,     x7,     x2
                                add             x5,     x5,     x7              // j++
                                b               1b
                  4:            nop

                                // Step 5: recursive calls!

                                // left side:
                                // sort(A, i, size)

                                // right side:
                                // sort(A + k + 1, len - k - 1, size)

                                // calculate i
                                sub             x4,     x4,     x0
                                lsr             x4,     x4,     x2

                                // calculate k + 1
                                sub             x5,     x6,     x0
                                lsr             x5,     x5,     x2
                                add             x5,     x5,    #1

                                // calculate len - k - 1
                                sub             x5,     x1,     x5

                                // reset x2 to raw size
                                mov             x7,    #1
                                lsl             x2,     x7,     x2

                                // get k + 1
                                add             x6,     x6,     x2

                                // Recursive call 1
                                // x0 = original array
                                // x1 = i
                                // x2 = original size
                                mov             x1,     x4
                                pushpair        x5,     x6
                                bl              _quicksort
                                poppair         x5,     x6
                                // Recursive call 2
                                // X0 = array + pivot (saved x4)
                                // X1 = len - pivot index (saved x5)
                                // X2 = original size
                                pushreg         x0
                                mov             x0,     x6
                                mov             x1,     x5
                                bl              _quicksort
                                popreg          x0
                                popreg          lr
                                ret

