# Two divisibility and remainder filters.
# Domain 1..1000 chosen to keep classroom output manageable.
# N=31: first list 6 7 14 16 21 26 28; second 6 18 30.
.data
prompt: .asciiz "N (1..1000): "
label1: .asciiz "Divisible by 7 OR ending in 6: "
label2: .asciiz "Divisible by 2 AND 3 but NOT 4: "
space: .asciiz " "
nl: .asciiz "\n"
invalid: .asciiz "Use an integer from 1 to 1000.\n"
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
    bgt $t0,1000,bad
    nop
    li $v0,4
    la $a0,label1
    syscall
    li $t1,1
or_loop:
    bgt $t1,$t0,second_list
    nop
    rem $t2,$t1,7
    beq $t2,$zero,or_print
    nop
    rem $t2,$t1,10
    bne $t2,6,or_next
    nop
or_print:
    li $v0,1
    move $a0,$t1
    syscall
    li $v0,4
    la $a0,space
    syscall
or_next:
    addiu $t1,$t1,1
    j or_loop
    nop
second_list:
    li $v0,4
    la $a0,nl
    syscall
    la $a0,label2
    syscall
    li $t1,1
and_loop:
    bgt $t1,$t0,done
    nop
    rem $t2,$t1,2
    bne $t2,$zero,and_next
    nop
    rem $t2,$t1,3
    bne $t2,$zero,and_next
    nop
    rem $t2,$t1,4
    beq $t2,$zero,and_next
    nop
    li $v0,1
    move $a0,$t1
    syscall
    li $v0,4
    la $a0,space
    syscall
and_next:
    addiu $t1,$t1,1
    j and_loop
    nop
done:
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
