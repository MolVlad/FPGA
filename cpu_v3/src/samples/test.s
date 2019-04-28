.text
.globl _start
.globl _finish

_start:
    li      x1,    0x0  #fib(0)
    li      x2,    0x1  #fib(1)
    li      x3,     0   #fib(-1)

    li      x4,    0x1  #counter
    li      x5,    0x12 #max counter

    li      x6,    0

_next:
    #fib(n) = fib(n-1) + fib(n-2)
    add     x3, x1, x2

    sw      x3,    0x20(zero)    # [0x20] <- x3

_delay:
    addi    x6, x6, 128
    bne     x6, x0, _delay

    mv      x1, x2
    mv      x2, x3

    addi    x4, x4, 1
    bne     x4, x5, _next

_finish:
    nop
.rept 5
    nop
.endr
