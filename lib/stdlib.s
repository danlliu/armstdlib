                //
                // Standard library functions
                //
                // DON'T INCLUDE THIS FILE!
                // .include "stdlib.i"
                // Trust me, it'll make your life easier
                //
                // ABI:
                //  x0:         parameter 1 and return value.
                //  x1 - x7:    paramters 2 - 8.
                //  x8 - x15:   caller-save registers.
                //  x16:        syscall register
                //  x19 - x28:  callee-save registers.

                .include        "macros.i"

                function        _exit
                                // x0 = exit code
                                mov             x16,   #1
                                svc            #0x80
                                ret

                function        _malloc
                                // x0 = B to allocate
                                mov             x1,     x0                                      // size
                                mov             x0,     xzr                                     // NULL
                                mov             x2,    #0x3                                     // PROT_READ | PROT_WRITE
                                mov             x3,    #0x1002                                  // MAP_ANONYMOUS | MAP_PRIVATE
                                mov             x4,    #-1                                      // fd = -1
                                mov             x5,    #0                                       // offset = 0
                                mov             x16,   #197                                     // mmap
                                svc            #0x80
                                ret

                function        _free
                                // x0 = pointer to deallocate
                                // x1 = B to deallocate
                                mov             x16,   #73                                      // munmap
                                svc            #0x80
                                ret


