# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input domain: integer n in 0..1000. Other integers print invalid input.
# Sums 0+1+...+(n-1), using the exclusive upper bound i < n.
# Tests: n=0 -> 0, n=1 -> 0, n=4 -> 6, n=1000 -> 499500.
.data
prompt: .asciiz "Enter n (0..1000): "
result: .asciiz "Sum of integers below n = "
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
    slt $t3, $t0, $zero
    bne $t3, $zero, bad_input
    nop
    slti $t3, $t0, 1001
    beq $t3, $zero, bad_input
    nop
    li $t1, 0            # i
    li $t2, 0            # total
loop_test:
    slt $t3, $t1, $t0    # Continue iff i < n
    beq $t3, $zero, done
    nop
    add $t2, $t2, $t1
    addi $t1, $t1, 1
    j loop_test
    nop
done:
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    j exit
    nop
bad_input:
    li $v0, 4
    la $a0, invalid
    syscall
exit:
    li $v0, 10
    syscall
