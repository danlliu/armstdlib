# armstdlib

Assembly is scary and hard to read. Why keep it that way? With the power of macros, I present...

The C and C++ standard libraries, re-written in ARMv8 assembly.

No more

```
mov x0, #0
mov x16, #1
svc 0x80
```

, only

```
exit #0
```

!

Runs on MacOS M1 chips. **This is not guaranteed to work (and will probably break) on any other architecture/OS**

## FAQs
* **How do I use this?**: Check out the test cases in [tst](tst)!
* **Why? Just why?**: I was bored.

