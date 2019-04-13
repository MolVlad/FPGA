.text
.globl _start
.globl _finish

_start:
    addi x1,  x0,  6
    addi x2,  x0,  -1

    slli x3, x1, 3
    srli x4, x1, 3
    srai x5, x1, 3

    slli x6, x2, 3
    srli x7, x2, 3
    srai x8, x2, 3

_finish:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
