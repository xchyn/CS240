# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input: one signed 32-bit integer.
# Expected: negative -> negative, 0 -> zero, positive -> positive.
.data
prompt: .asciiz "Enter an integer: "
positive: .asciiz "positive\n"
negative: .asciiz "negative\n"
zero_text: .asciiz "zero\n"
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    slt $t1, $zero, $t0   # t1 = (0 < x)
    bne $t1, $zero, is_positive
    nop
    beq $t0, $zero, is_zero
    nop
    la $a0, negative     # x is neither positive nor zero
    j print_result
    nop
is_positive:
    la $a0, positive
    j print_result
    nop
is_zero:
    la $a0, zero_text
print_result:
    li $v0, 4
    syscall
    li $v0, 10
    syscall
