.text
.globl _start
.globl _finish
.globl main

_start:
    call main

_finish:
    li x10, 0x20
    nop
.rept 10
    nop
.endr
