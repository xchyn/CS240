# One standalone program: static data, heap, stack, and registers.
# Use a fresh run with MARS's Default memory configuration.
# Expected output: Hi, A, 21, and 99 on separate lines.

.data
age:      .word 20          # 0x10010000..0x10010003
greeting: .asciiz "Hi\n"    # 0x10010004..0x10010007: H, i, newline, NUL
buffer:   .space 4          # 0x10010008..0x1001000b: four reserved bytes

.text
.globl main
main:
    # A. Read a static word, change the register copy, then store it back.
    la    $t0, age          # $t0 = address 0x10010000
    lw    $t1, 0($t0)       # $t1 = value 20; memory still holds 20
    addiu $t1, $t1, 1       # $t1 = 21; memory still holds 20
    sw    $t1, 0($t0)       # static word at 0x10010000 now holds 21

    # B. Request two words of heap storage and write both words.
    li    $a0, 8            # request 8 bytes, enough for two 4-byte words
    li    $v0, 9            # MARS service 9: allocate heap storage
    syscall                # $v0 = first block's address, 0x10040000
    move  $s0, $v0          # keep that address in a register
    sw    $t1, 0($s0)       # heap word at 0x10040000 = 21
    li    $t2, 99           # register $t2 = 99
    sw    $t2, 4($s0)       # heap word at 0x10040004 = 99

    # C. Reserve stack space and explicitly save a value and an address.
    addiu $sp, $sp, -8      # 0x7fffeffc -> 0x7fffeff4
    sw    $t1, 0($sp)       # stack word at 0x7fffeff4 = 21
    sw    $s0, 4($sp)       # stack word at 0x7fffeff8 = 0x10040000
    li    $t1, 0            # overwrites only $t1; all memory copies remain
    lw    $t3, 0($sp)       # $t3 = saved value 21
    lw    $t4, 4($sp)       # $t4 = saved address 0x10040000
    lw    $t5, 4($t4)       # $t5 = heap word at 0x10040004 = 99
    addiu $sp, $sp, 8       # restore original $sp; release the 8-byte area

    # D. Write a short string into the static buffer.
    la    $t6, buffer       # $t6 = 0x10010008
    li    $t7, 65           # ASCII code for A
    sb    $t7, 0($t6)       # one byte at 0x10010008 = 65
    sb    $zero, 1($t6)     # one byte at 0x10010009 = 0, the terminator

    # E. Print the strings and the two values we loaded.
    li    $v0, 4            # print a NUL-terminated string at address $a0
    la    $a0, greeting
    syscall                # prints Hi and the newline stored in greeting
    li    $v0, 4
    move  $a0, $t6
    syscall                # prints A; buffer's NUL is not printed
    li    $v0, 11           # print one character whose code is in $a0
    li    $a0, 10           # ASCII newline
    syscall
    li    $v0, 1            # print the integer value in $a0
    move  $a0, $t3
    syscall                # prints 21
    li    $v0, 11
    li    $a0, 10
    syscall
    li    $v0, 1
    move  $a0, $t5
    syscall                # prints 99
    li    $v0, 11
    li    $a0, 10
    syscall
    li    $v0, 10           # exit
    syscall
