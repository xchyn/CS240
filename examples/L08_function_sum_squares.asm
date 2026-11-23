# MARS: pseudo-instructions enabled; delayed branching OFF.
.text
.globl main
main:
    li $v0,5
    syscall
    move $a0,$v0           # n
    jal sumSquares
    move $a0,$v0
    li $v0,1
    syscall
    li $a0,10
    li $v0,11
    syscall
    li $v0,10
    syscall

sumSquares:
    move $v0,$zero         # total = 0
    li $t0,1               # i = 1
squares_loop:
    slt $t2,$a0,$t0        # n < i?
    bne $t2,$zero,squares_done
    mul $t1,$t0,$t0
    addu $v0,$v0,$t1
    addiu $t0,$t0,1
    j squares_loop
squares_done:
    jr $ra
