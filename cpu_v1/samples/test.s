.text
.globl _start
.globl _finish

_start:
    addi x6,  x0,  11
    addi x5,  x0,  15
    addi x4,  x0,  19
    ori  x3,  x6,  12
    xori x2,  x5,  11
    andi x1, x4, 15

_finish:
    nop
    nop
