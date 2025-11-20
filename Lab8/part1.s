.global _start

# base address
.equ LED_BASE, 0xFF200000
.equ KEY_BASE, 0xFF200050

_start:
    li s0, LED_BASE
    li s1, KEY_BASE
    li s2,1
    li s3,0

    sw s2, 0(s0)

poll_keys:
    lw t0, 0(s1)
    andi t0, t0, 0xF
    beq t0, zero, poll_keys

    mv s4, t0

wait_release:
    lw t0, 0(s1)
    andi t0, t0, 0xF
    bnez t0, wait_release

    andi t2, s4, 8
    bnez t2, handle_key_3

    bnez s3, unblank_logic

    andi t2, s4, 1
    bnez t2, handle_key_0

    andi t2, s4, 2
    bnez t2, handle_key_1

    andi t2, s4, 4
    bnez t2, handle_key_2

    j poll_keys

handle_key_3:
    li s3, 1
    sw zero, 0(s0)
    j poll_keys

unblank_logic:
    li s2, 1
    li s3, 0
    sw s2, 0(s0)
    j poll_keys

handle_key_0:
    li s2, 1
    sw s2, 0(s0)
    j poll_keys

handle_key_1:
    li t2, 15
    bge s2, t2, poll_keys
    addi s2, s2, 1
    sw s2, 0(s0)
    j poll_keys

handle_key_2:
    li t2, 1
    ble s2, t2, poll_keys
    addi s2, s2, -1
    sw s2, 0(s0)
    j poll_keys