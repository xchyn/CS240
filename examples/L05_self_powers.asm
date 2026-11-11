# Sum i^i for i=1..N.
# MARS: pseudoinstructions enabled, delayed branching OFF.
# Input domain 1..9; every intermediate/result fits signed 32-bit.
.data
prompt: .asciiz "N (1..9): "
label: .asciiz "Sum = "
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
    move $t0,$v0             # N
    blt $t0,1,bad
    nop
    bgt $t0,9,bad
    nop
    li $t1,1                # i
    li $t2,0                # total
outer:
    bgt $t1,$t0,done
    nop
    li $t3,0                # completed multiplications; RESET each i
    li $t4,1                # term = i^0; RESET each i
inner:
    bge $t3,$t1,add_term
    nop
    mul $t4,$t4,$t1
    addiu $t3,$t3,1
    j inner
    nop
add_term:
    addu $t2,$t2,$t4
    addiu $t1,$t1,1
    j outer
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
