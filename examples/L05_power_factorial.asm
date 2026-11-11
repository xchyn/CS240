# Compute N^N + N! using one loop.
# Domain 1..9; N=4 -> 280; N=9 -> 387783369.
.data
prompt: .asciiz "N (1..9): "
label: .asciiz "N^N + N! = "
invalid: .asciiz "Use an integer from 1 to 9.\n"
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
    bgt $t0,9,bad
    nop
    li $t1,1                # i
    li $t2,1                # power
    li $t3,1                # factorial
loop:
    bgt $t1,$t0,done
    nop
    mul $t2,$t2,$t0          # multiply by fixed N
    mul $t3,$t3,$t1          # multiply by changing i
    addiu $t1,$t1,1
    j loop
    nop
done:
    addu $t4,$t2,$t3
    li $v0,4
    la $a0,label
    syscall
    li $v0,1
    move $a0,$t4
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
