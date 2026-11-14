# Alignment and little-endian byte order in MARS.
# Assemble and run this file by itself with Default memory configuration.
# No console output: inspect the registers and Data Segment after running.
# Expected: $t0=0x10010004, $t1=0x12345678,
#           $t2=0x78, $t3=0x56, $t4=0x34, $t5=0x12.

.data
flag:   .byte 7            # one byte at 0x10010000
.align 2                  # next item on a 2^2 = 4-byte boundary
number: .word 0x12345678   # four bytes beginning at 0x10010004

.text
.globl main
main:
    la  $t0, number        # address, not the stored integer
    lw  $t1, 0($t0)       # whole word: 0x12345678
    lbu $t2, 0($t0)       # byte at 0x10010004: 0x78 = decimal 120
    lbu $t3, 1($t0)       # byte at 0x10010005: 0x56 = decimal 86
    lbu $t4, 2($t0)       # byte at 0x10010006: 0x34 = decimal 52
    lbu $t5, 3($t0)       # byte at 0x10010007: 0x12 = decimal 18
    li  $v0, 10           # exit; nothing is printed
    syscall
