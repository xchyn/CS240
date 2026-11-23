# Read an integer, call a leaf function, print its result, and exit.
# Input domain: -1000..1000. Input 4 prints 7; input -3 prints 0.
# MARS: delayed branching OFF.
.text
.globl main
main: li $v0,5
syscall
move $a0,$v0
li $a1,3
jal add_offset
move $a0,$v0
li $v0,1
syscall
li $a0,10
li $v0,11
syscall
li $v0,10
syscall
add_offset: addu $v0,$a0,$a1
jr $ra
