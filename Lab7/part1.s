.global _start
.text

_start:
    la s0, LIST # original address
    lw s1, 0(s0) # current element value
    add s2, zero, s0 # current memory address
    addi s10, zero, 0 # answer
    addi s3, zero, -1 # array end indicator

LOOP1:
    beq s1, s3, END # break if last element
    addi a0, s1, 0
    jal  ONES # run ONES
    ble a0, s10, SKIP # if le past best
    addi s10, a0, 0 # update if gt
SKIP:
    addi s2, s2, 4 # move address up by 4
    lw s1, 0(s2) # store
    j LOOP1
END: j END

ONES:     # find longest string of ones
    addi t0, zero, 0 # number of ones

    LOOP:
        beqz a0, LOOPEND # if current string (a0) to check equals 0
        srli t1, a0, 1 # logical right shift -> store in t1
        and a0, a0, t1 # AND t1 and a0
        addi t0, t0, 1 # increment number of ones by 1
        j LOOP
    LOOPEND:
        addi a0, t0, 0 # store number of ones (t0) into a0
        jr ra # jump back



.global LIST
.data
LIST:
.word 0x103fe00f, 0x12344478, 0xffffffdf, 0x00f0f0f0, 0x453627AB, 0x4FFF07AB, 0x0000ffff, 0xABCDEF01, 0x87654321, 0x0000000F, -1

