# Byte addresses, words, array indexing, signed/unsigned bytes.
# Expected: Sum = 20; Updated A[2] = 12; lb = -1; lbu = 255.
.data
.align 2
array: .word 10,-3,7,6
raw: .byte 255
sum_label: .asciiz "Sum = "
update_label: .asciiz "Updated A[2] = "
lb_label: .asciiz "lb = "
lbu_label: .asciiz "lbu = "
nl: .asciiz "\n"
.text
.globl main
main:
    la $t0,array             # base ADDRESS
    li $t1,0                # index i
    li $t2,0                # total
loop:
    bge $t1,4,done
    nop
    sll $t3,$t1,2           # byte offset = i * 4
    addu $t4,$t0,$t3        # element ADDRESS
    lw $t5,0($t4)           # element VALUE
    addu $t2,$t2,$t5
    addiu $t1,$t1,1
    j loop
    nop
done:
    lw $t5,8($t0)           # A[2]
    addiu $t5,$t5,5
    sw $t5,8($t0)           # store changes RAM
    li $v0,4
    la $a0,sum_label
    syscall
    li $v0,1
    move $a0,$t2
    syscall
    li $v0,4
    la $a0,nl
    syscall
    la $a0,update_label
    syscall
    li $v0,1
    lw $a0,8($t0)
    syscall
    li $v0,4
    la $a0,nl
    syscall
    la $a0,lb_label
    syscall
    la $t6,raw
    lb $a0,0($t6)
    li $v0,1
    syscall
    li $v0,4
    la $a0,nl
    syscall
    la $a0,lbu_label
    syscall
    lbu $a0,0($t6)
    li $v0,1
    syscall
    li $v0,4
    la $a0,nl
    syscall
    li $v0,10
    syscall
