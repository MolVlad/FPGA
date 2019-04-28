.text
.globl _start
.globl _finish

_start:
    li      x3,     0x234
    sw      x3,     0x20(x0)    # [0x20] <- x3

    li      x1,     -3
    li      x2,     -2
    bltu     x1,     x2, _finish

    li      x3,     0x0000
    sw      x3,     0x20(x0)    # [0x20] <- x3

_finish:
    nop
.rept 16
    nop
.endr
