.text
.globl _start
.globl _finish

_start:
    addi x1,  x0,  50
    addi x2,  x0,  39
    add x3,  x1,  x2
    xor x4,  x1,  x2
    or x5,  x1,  x2
    and x6,  x1,  x2

_finish:
    nop
    nop
