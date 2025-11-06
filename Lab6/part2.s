.global _start
.text
_start:
    la s2, LIST
    lw s3, 0(s2)
    addi s4, zero, 0

LOOP:
    beqz s3, END
    srli s2, s3
    and s3, s3, s2
    addi s4, s4, 1
    j LOOP

END: j END

.global LIST
.data
LIST:
.word 0x103fe00f

