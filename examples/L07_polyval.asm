# Leaf procedure: a*x*x + b*x + c.
# Contract: a0=x, a1=a, a2=b, a3=c; result v0.
# Clobbers t0,t1,v0; preserves s0-s7, sp; no nested calls.
# Fixed small operands have no overflow. Expected result 44; t0=27,t1=17.
.data
label: .asciiz "Polynomial = "
temp_label: .asciiz "$t0 after call = "
nl: .asciiz "\n"
.text
.globl main
main:
    li $t0,3               # x
    li $t1,3               # a
    li $t2,4               # b
    li $t3,5               # c
    move $a0,$t0
    move $a1,$t1
    move $a2,$t2
    move $a3,$t3
    jal polyval
    nop
    move $t4,$v0           # keep result before selecting a syscall
    li $v0,4
    la $a0,label
    syscall
    li $v0,1
    move $a0,$t4
    syscall
    li $v0,4
    la $a0,nl
    syscall
    la $a0,temp_label
    syscall
    li $v0,1
    move $a0,$t0
    syscall
    li $v0,4
    la $a0,nl
    syscall
    li $v0,10
    syscall
polyval:
    mul $t0,$a0,$a0        # x*x
    mul $t0,$t0,$a1        # a*x*x
    mul $t1,$a0,$a2        # b*x
    addu $t1,$t1,$a3       # b*x+c
    addu $v0,$t0,$t1       # result
    jr $ra
    nop
