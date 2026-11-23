# Input: N in 0..5, then N integers in -100..100; one integer per line.
# MARS: pseudo-instructions enabled; delayed branching OFF.
.data
.align 2
values: .space 20
.text
.globl main
main:
    li $v0,5
    syscall
    move $s0,$v0
    la $s1,values
    li $t0,0
read_loop: slt $t1,$t0,$s0
    beq $t1,$zero,read_done
    li $v0,5
    syscall
    sll $t1,$t0,2
    addu $t1,$s1,$t1
    sw $v0,0($t1)
    addiu $t0,$t0,1
    j read_loop
read_done: move $a0,$s1
    move $a1,$s0
    jal sumArray
    move $a0,$v0
    li $v0,1
    syscall
    li $a0,10
    li $v0,11
    syscall
    li $v0,10
    syscall
sumArray: li $v0,0
    li $t0,0
sum_loop: slt $t1,$t0,$a1
    beq $t1,$zero,sum_done
    sll $t1,$t0,2
    addu $t1,$a0,$t1
    lw $t2,0($t1)
    addu $v0,$v0,$t2
    addiu $t0,$t0,1
    j sum_loop
sum_done: jr $ra
