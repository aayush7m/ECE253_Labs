.global _start

.equ LED_BASE, 0xFF200000
.equ KEY_BASE, 0xFF200050
.equ EDGE_OFFSET, 12
.equ DELAY_VAL, 10000000

_start:
    li s0, LED_BASE
    li s1, KEY_BASE
    li s2, 0
    li s3, 1

    li t0, 0xF
    sw t0, EDGE_OFFSET(s1)

loop:
    sw s2, 0(s0)
    
    lw t0, EDGE_OFFSET(s1)
    beqz t0, check_state

    sw t0, EDGE_OFFSET(s1)

    xori s3, s3, 1

check_state:
    beqz s3, loop

    li a0, DELAY_VAL
    jal ra, do_delay

    addi s2, s2, 1
    li t1, 255
    bgt s1, t1, reset_count
    j loop

reset_count:
    li s2, 0
    j loop

do_delay:
    addi a0, a0, -1
    bnez a0, do_delay
    jr ra