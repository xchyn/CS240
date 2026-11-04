# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input: one signed 32-bit integer.
# Prints accepted exactly for 2,4,6,8; otherwise rejected.
# Tests: x > 0 AND x < 10 AND x is even.
.data
prompt: .asciiz "Enter an integer: "
accept: .asciiz "accepted\n"
reject: .asciiz "rejected\n"
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    slt $t1, $zero, $t0
    beq $t1, $zero, rejected
    nop
    slti $t1, $t0, 10
    beq $t1, $zero, rejected
    nop
    andi $t1, $t0, 1     # Low bit 0 means even; low bit 1 means odd
    bne $t1, $zero, rejected
    nop
    la $a0, accept
    j print_result
    nop
rejected:
    la $a0, reject
print_result:
    li $v0, 4
    syscall
    li $v0, 10
    syscall
