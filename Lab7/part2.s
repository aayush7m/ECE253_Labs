.global _start
.text

_start:
la s0, LIST
addi s1, zero, -1 # s1 = number of swaps
lw s2, 0(s0) # s2 = list length
slli s2, s2, 2 # address shift of last element
add s2, s0, s2 # address of last element
addi s0, s0, 4 # address of first element

LOOP_NO_SWAPS:
    beqz s1, END_LOOP_NO_SWAPS # break if no swaps are done
    addi s1, zero, 0 # update number of swaps to 0
    add s3, s0, zero # s3 = address of lower element being compared
    LOOP_THRU_LIST:
        beq s3, s2, END_LOOP_THRU_LIST # break if on last element
        addi a0, s3, 0 # current element address, initial address + address shift
        jal SWAP
        or s1, a0, s1 # update number of swaps
        addi s3, s3, 4 # update address to next element
        j LOOP_THRU_LIST
    END_LOOP_THRU_LIST:
    addi s2, s2, -4 # one less loop b/c last element in order
    j LOOP_NO_SWAPS

SWAP:
lw t0, 0(a0) # t0 stores first element
lw t1, 4(a0) # t1 stores second element
ble t0, t1, IF_LE # break if elements in increasing order
    # decreasing order
    sw t0, 4(a0) # left element goes to right
    sw t1, 0(a0) # right element goes to left
    addi a0, zero, 1 # swap performed. return 1 
    j END_IF_GR
IF_LE: # if increasing order
    addi a0, zero, 0 # no swap. return 0.

END_IF_GR:
    jr ra

END_LOOP_NO_SWAPS:

END: j END

.global LIST
.data
LIST:
.word 10, 140, 35, 23, 5, 35, 9, 17, 4, 20, 330

