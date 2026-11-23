# Input: one integer x in -1000..1000. Output: -1, 0, or 1, then newline.
# MARS: pseudo-instructions enabled; delayed branching OFF.
.text
.globl main
main:
    li $v0,5
    syscall
    move $a0,$v0
    jal classifySign
    move $a0,$v0
    li $v0,1
    syscall
    li $a0,10
    li $v0,11
    syscall
    li $v0,10
    syscall
classifySign: slt $t0,$a0,$zero
    bne $t0,$zero,negative
    slt $v0,$zero,$a0
    jr $ra
negative: li $v0,-1
    jr $ra
