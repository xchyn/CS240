# Reverse a string by swapping bytes with two inward-moving pointers.
# Read <=127 bytes, discard captured line-feed, reverse before the zero byte.
# ASCII text only; no Unicode character-boundary handling.
# Input Tom and Harry -> yrraH dna moT. Empty string is valid.
.data
prompt: .asciiz "Text (at most 126 ASCII characters recommended): "
result: .asciiz "Reversed: "
buffer: .space 128
nl: .asciiz "\n"
.text
.globl main
main:
    li $v0,4
    la $a0,prompt
    syscall
    li $v0,8
    la $a0,buffer
    li $a1,128
    syscall
    la $t0,buffer           # left pointer
    move $t1,$t0           # scan pointer
scan:
    lbu $t2,0($t1)
    beq $t2,$zero,found_end
    nop
    beq $t2,10,trim_newline
    nop
    addiu $t1,$t1,1
    j scan
    nop
trim_newline:
    sb $zero,0($t1)
found_end:
    beq $t1,$t0,done        # empty string: do not form/read before buffer
    nop
    addiu $t1,$t1,-1       # right pointer, last actual character
reverse:
    sltu $t4,$t0,$t1        # continue while left < right
    beq $t4,$zero,done
    nop
    lbu $t2,0($t0)
    lbu $t3,0($t1)
    sb $t3,0($t0)
    sb $t2,0($t1)
    addiu $t0,$t0,1
    addiu $t1,$t1,-1
    j reverse
    nop
done:
    li $v0,4
    la $a0,result
    syscall
    la $a0,buffer
    syscall
    la $a0,nl
    syscall
    li $v0,10
    syscall
