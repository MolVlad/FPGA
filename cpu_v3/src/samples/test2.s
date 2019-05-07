.text
.globl _start
.globl _finish
.globl main

_start:
  call _main
  li  x15, 0x228
  call _finish
  li  x15, 0

_main:
  li t0, 0
  li t1, 1
  li t3, 1
  li t4, 0x12

_next:
  add t2, t1, t0
  sw t2, 0x20(zero)

  mv t0, t1
  mv t1, t2

  addi t3, t3, 1
  bne t3, t4, _next

  ret

_finish:
    nop
.rept 16
    nop
.endr
