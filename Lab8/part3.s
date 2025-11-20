.global _start

.equ LED_BASE, 0xFF200000
.equ KEY_BASE, 0xFF200050
.equ TIMER_BASE, 0xFF202000

.equ STATUS_OFF, 0
.equ CONTROL_OFF, 4
.equ LO_OFF, 8
.equ HI_OFF, 12
.equ EDGE_OFFSET, 12

.equ PERIOD_LO, 0x7840
.equ PERIOD_HI, 0x017D

_start:
    li s0, LED_BASE
    li s1, KEY_BASE
    li s4, TIMER_BASE
    li s2, 0
    li s3, 1

    sw zero, CONTROL_OFF(s4)

    li t0, PERIOD_LO
    sw t0, LO_OFF(s4)

    li t0, PERIOD_HI
    sw t0, HI_OFF(s4)

    li t0, 6
    sw t0, CONTROL_OFF(s4)

loop:
    sw s2, 0(s0)

    lw t0, EDGE_OFFSET(s1)
    beqz t0, check_timer_flag

    sw t0, EDGE_OFFSET(s1)
    xori s3, s3, 1

check_timer_flag:
    lw t0, STATUS_OFF(s4)
    andi t0, t0, 1
    beqz t0, loop

    sw zero, STATUS_OFF(s4)

    beqz s3, loop

    addi s2, s2, 1
    li t1, 255
    bgt s2, t1, reset_count
    j loop

reset_count:
    li s2, 0
    j loop