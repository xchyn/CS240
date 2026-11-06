# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input: signed 32-bit integers, one per line. -1 terminates.
# Example inputs 5,0,-1 -> echoes 5 and 0; never echoes -1.
.data
prompt: .asciiz "Enter an integer (-1 stops): "
result: .asciiz "You entered: "
newline: .asciiz "\n"
.text
.globl main
main:
    li $t1, -1           # Sentinel
read_next:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    beq $t0, $t1, done
    nop
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    j read_next
    nop
done:
    li $v0, 10
    syscall
