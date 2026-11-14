# INTENTIONALLY FAILING demonstration. Run separately from other examples.
# MARS reports an unaligned word-load address: 0x10010005.
# Repair: use lw $t1,0($t0) for number, or lbu $t1,1($t0) for one byte.

.data
flag:   .byte 7
.align 2
number: .word 0x12345678

.text
.globl main
main:
    la  $t0, number        # aligned base: 0x10010004
    lw  $t1, 1($t0)       # ERROR: effective address = 0x10010005
    li  $v0, 10           # not reached during the failing run
    syscall
