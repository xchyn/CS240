# MARS: pseudo-instructions enabled; delayed branching OFF.
.text
.globl main
main:
    li $v0,5
    syscall
    move $s0,$v0           # keep x while reading y
    li $v0,5
    syscall
    move $a1,$v0           # y
    move $a0,$s0           # x
    jal twice_plus
    move $a0,$v0           # preserve result as print argument
    li $v0,1
    syscall
    li $a0,10
    li $v0,11
    syscall
    li $v0,10
    syscall

twice_plus:
    addu $t0,$a0,$a0       # 2*x
    addu $v0,$t0,$a1       # 2*x+y
    jr $ra
