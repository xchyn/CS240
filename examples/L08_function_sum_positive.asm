# MARS: pseudo-instructions enabled; delayed branching OFF.
.data
.align 2
values: .word 3,-2,0,7,-1
.text
.globl main
main:
    la $a0,values
    li $a1,5
    jal sumPositive
    move $a0,$v0
    li $v0,1
    syscall
    li $a0,10
    li $v0,11
    syscall
    li $v0,10
    syscall

sumPositive:
    move $v0,$zero         # total = 0
    move $t0,$a0           # moving word pointer
    li $t1,0               # i = 0
positive_loop:
    slt $t3,$t1,$a1        # i < n?
    beq $t3,$zero,positive_done
    lw $t2,0($t0)
    slt $t3,$zero,$t2      # a[i] > 0?
    beq $t3,$zero,positive_next
    addu $v0,$v0,$t2
positive_next:
    addiu $t0,$t0,4
    addiu $t1,$t1,1
    j positive_loop
positive_done:
    jr $ra
