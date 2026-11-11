# Alternating-square sum: 1^2 - 2^2 + 3^2 - ...
# Domain 1..46340 keeps EACH square and every partial sum signed 32-bit.
# N=3 -> 6; N=4 -> -10. Arithmetic is integer, not floating point.
.data
prompt: .asciiz "N (1..46340): "
label: .asciiz "Alternating sum = "
invalid: .asciiz "Use an integer from 1 to 46340.\n"
nl: .asciiz "\n"
.text
.globl main
main:
    li $v0,4
    la $a0,prompt
    syscall
    li $v0,5
    syscall
    move $t0,$v0
    blt $t0,1,bad
    nop
    bgt $t0,46340,bad
    nop
    li $t1,1
    li $t2,0
loop:
    bgt $t1,$t0,done
    nop
    mul $t3,$t1,$t1
    andi $t4,$t1,1           # odd iff low bit is 1
    beq $t4,$zero,even
    nop
    addu $t2,$t2,$t3
    j advance
    nop
even:
    subu $t2,$t2,$t3
advance:
    addiu $t1,$t1,1
    j loop
    nop
done:
    li $v0,4
    la $a0,label
    syscall
    li $v0,1
    move $a0,$t2
    syscall
    li $v0,4
    la $a0,nl
    syscall
    j exit
    nop
bad:
    li $v0,4
    la $a0,invalid
    syscall
exit:
    li $v0,10
    syscall
