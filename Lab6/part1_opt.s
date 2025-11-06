.global _start
.text

_start:
    la s2, LIST
    addi s10, zero, 0
    addi s11, zero, 0
    
    addi t1, zero, -1
    
    LOOP:
        lw t0, 0(s2)
        BEQ t0, t1, END
        add s11, s11, 1
        add s10, s10, t0
        addi s2, s2, 4
        j LOOP
    
END: j END

.global LIST
.data
LIST:
.word 1, 2, 3, 5, 0xA, -1