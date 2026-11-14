# Inspect static declarations, then read and update their bytes and words.
# Expected program output: 7, 12, A, and Hi, each on its own line.
# Use default MARS memory, pseudo-instructions ON, delayed branching OFF.
# In this fresh program: flag=0x10010000, array=0x10010004,
# buffer=0x10010014, message=0x1001001c. Inspect actual labels in MARS.
.data
flag:    .byte 7
.align 2
array:   .word 10, -3, 7, 6
buffer:  .space 8
message: .asciiz "Hi\n"

.text
.globl main
main:
    la $t0, array        # Get the address; do not load an element yet.
    lw $t1, 8($t0)       # A[2] begins 8 bytes after the array's base.
    move $a0, $t1
    li $v0, 1           # Print integer 7.
    syscall
    li $a0, 10          # ASCII newline character.
    li $v0, 11          # Print one character.
    syscall

    addiu $t1, $t1, 5   # The register becomes 12; memory is still 7.
    sw $t1, 8($t0)       # Now the array's third word becomes 12.
    lw $a0, 8($t0)       # Read back the stored value.
    li $v0, 1
    syscall
    li $a0, 10
    li $v0, 11
    syscall

    la $t2, buffer
    li $t3, 65          # ASCII A.
    sb $t3, 0($t2)       # Initialize the first byte.
    sb $zero, 1($t2)     # Initialize the terminator before printing.
    move $a0, $t2
    li $v0, 4           # Print zero-terminated string A.
    syscall
    li $a0, 10
    li $v0, 11
    syscall

    la $a0, message
    li $v0, 4           # The declared message already includes newline.
    syscall
    li $v0, 10
    syscall
