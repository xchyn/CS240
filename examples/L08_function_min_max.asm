# Input: x and y in -1000..1000, one integer per line.
# MARS: pseudo-instructions enabled; delayed branching OFF.
.text
.globl main
main:
    li $v0,5
    syscall
    move $s1,$v0
    li $v0,5
    syscall
    move $s2,$v0
    move $a0,$s1
    move $a1,$s2
    jal minValue
    move $s0,$v0
    move $a0,$s1
    move $a1,$s2
    jal maxValue
    move $t2,$v0
    move $a0,$s0
    li $v0,1
    syscall
    li $a0,32
    li $v0,11
    syscall
    move $a0,$t2
    li $v0,1
    syscall
    li $a0,10
    li $v0,11
    syscall
    li $v0,10
    syscall
minValue: move $v0,$a0
    slt $t0,$a1,$a0
    beq $t0,$zero,min_done
    move $v0,$a1
min_done: jr $ra
maxValue: move $v0,$a0
    slt $t0,$a0,$a1
    beq $t0,$zero,max_done
    move $v0,$a1
max_done: jr $ra
