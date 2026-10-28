# MARS: pseudo-instructions enabled; delayed branching OFF.
# Assemble only this file. All examples are standalone.
# Input: none. Expected output: Hello, MIPS! followed by newline.
.data
greeting: .asciiz "Hello, MIPS!\n"
.text
.globl main
main:
    li $v0, 4             # MARS print-string service
    la $a0, greeting      # Address of first character, not the characters
    syscall
    li $v0, 10            # MARS exit service
    syscall
