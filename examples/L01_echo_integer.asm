# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input: one signed 32-bit decimal integer, entered on its own line.
# Example input: -7. Expected final line: You entered: -7
.data
prompt: .asciiz "Enter an integer: "
result: .asciiz "You entered: "
newline: .asciiz "\n"
.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 5             # Input is returned in $v0
    syscall
    move $t0, $v0         # Preserve input before selecting another service
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t0         # Print integer value, not its address
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 10
    syscall
