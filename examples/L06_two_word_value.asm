# One 64-bit value represented explicitly by two 32-bit words.
# Run this file by itself with the Default MARS memory configuration.
# No console output. Inspect the registers and memory after the loads.
# Expected: $t0=0x10010000, $t1=0x55667788 (low), $t2=0x11223344 (high).

.data
.align 2                  # align to four bytes for the two ordinary lw accesses
value64: .word 0x55667788, 0x11223344
# Low word:  0x10010000..0x10010003; bytes 88 77 66 55 in increasing address order.
# High word: 0x10010004..0x10010007; bytes 44 33 22 11 in increasing address order.
# Together, by our chosen representation: high:low = 0x1122334455667788.

.text
.globl main
main:
    la  $t0, value64       # $t0 gets the starting address, 0x10010000
    lw  $t1, 0($t0)       # copy low 32 bits from address 0x10010000
    lw  $t2, 4($t0)       # copy high 32 bits from address 0x10010004
    li  $v0, 10           # select exit; this program prints nothing
    syscall
