# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input domain: integer n in 1..2000. Other integers print invalid input.
# Print each i in 1..n divisible by 2 AND 3 but NOT 4, once per line.
# n=31 -> lines 6,18,30; n=5 -> no numbers; n=6 -> 6.
.data
prompt: .asciiz "Enter n (1..2000): "
invalid: .asciiz "invalid input\n"
newline: .asciiz "\n"
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0        # n
    slt $t2, $zero, $t0
    beq $t2, $zero, bad_input
    nop
    slti $t2, $t0, 2001
    beq $t2, $zero, bad_input
    nop
    li $t1, 1            # i
loop_test:
    slt $t2, $t0, $t1
    bne $t2, $zero, done
    nop
    li $t3, 2
    div $t1, $t3
    mfhi $t4
    bne $t4, $zero, next_i
    nop
    li $t3, 3
    div $t1, $t3
    mfhi $t4
    bne $t4, $zero, next_i
    nop
    li $t3, 4
    div $t1, $t3
    mfhi $t4
    beq $t4, $zero, next_i
    nop
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
next_i:
    addi $t1, $t1, 1
    j loop_test
    nop
bad_input:
    li $v0, 4
    la $a0, invalid
    syscall
done:
    li $v0, 10
    syscall
