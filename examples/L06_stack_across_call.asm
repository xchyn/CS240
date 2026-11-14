# Keep a temporary-register value across a function call.
# Run this file by itself in MARS. Expected output: 21.
# With Default memory configuration and no program arguments:
# heap word = 0x10040000; initial $sp = 0x7fffeffc.

.text
.globl main
main:
    li    $t1, 21          # CPU register holds the value we need later

    # Heap: establish the register-to-memory pointer from the diagram.
    li    $a0, 4           # request four bytes, enough for one word
    li    $v0, 9           # MARS heap-allocation service
    syscall                # $v0 receives the allocated address
    move  $s0, $v0         # keep the heap address in a CPU register
    sw    $t1, 0($s0)      # heap word at 0x10040000 = 21

    # Stack: save the value before a function reuses $t1.
    addiu $sp, $sp, -8     # reserve 8 bytes; $sp = 0x7fffeff4
    sw    $t1, 0($sp)      # save 21 in the first word; other 4 bytes unused
    jal   do_work          # call the helper; $ra receives a return address
    nop                    # no operation; also safe with delayed branching
    lw    $t1, 0($sp)      # recover 21 after the helper changed $t1
    addiu $sp, $sp, 8      # release the reservation; $sp = 0x7fffeffc

    # Print the restored value, then exit instead of falling into do_work.
    move  $a0, $t1         # integer-print argument is the value itself
    li    $v0, 1           # MARS print-integer service
    syscall                # prints 21
    li    $v0, 10          # MARS exit service
    syscall

do_work:
    li    $t1, 99          # temporary registers may be reused by a callee
    jr    $ra              # return to the caller
    nop                    # no operation
