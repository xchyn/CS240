# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input: none. Printed lines: 8, -15, -2, -1.
# Also inspect registers before exit: t3=-2 t4=7 t5=1 t6=6 t7=-8 t8=-4 t9=48;
# s0=2147483646 (0x7ffffffe); s1=-2; s2=-15; s3=-2; s4=-1.
.data
newline: .asciiz "\n"
.text
.globl main
main:
    li $t0, 3
    li $t1, 5
    add $t2, $t0, $t1
    sub $t3, $t0, $t1
    or $t4, $t0, $t1
    and $t5, $t0, $t1
    xor $t6, $t0, $t1
    nor $t7, $t0, $t1
    nor $t8, $t0, $zero   # Basic-instruction form of NOT
    sll $t9, $t0, 4
    li $s5, -3
    srl $s0, $s5, 1
    sra $s1, $s5, 1
    li $t1, -5
    mult $t0, $t1        # Signed 64-bit product in HI:LO
    mflo $s2             # Save product BEFORE division overwrites HI/LO
    li $t0, -7
    li $t1, 3            # Nonzero divisor; excludes INT_MIN / -1 case
    div $t0, $t1
    mflo $s3             # Quotient = -2, truncated toward zero
    mfhi $s4             # Remainder = -1: -7 = 3*(-2) + (-1)
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $s2
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $s3
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $s4
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 10
    syscall
