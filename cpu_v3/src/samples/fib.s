.text
.globl _main

_main:
  li t0, 0
  li t1, 1
  li t3, 0
  li t4, 12

_next:
  add t2, t1, t0
  sw t2, 0x20(zero)

  mv t0, t1
  mv t1, t2
  addi t3, t3, 1
  bne t3, t4, _next

_finish:
    nop
.rept 20
    nop
.endr
