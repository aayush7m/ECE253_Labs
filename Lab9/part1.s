.global _start
_start:

	.equ LEDs,  	  0xFF200000
	.equ TIMER, 	  0xFF202000
	.equ PUSH_BUTTON, 0xFF200050
	.equ TOP_COUNT, 25000000

	#Set up the stack pointer
	
	li      sp, 0x20000         # set stack pointer

    csrw    mstatus, zero       # turn OFF global interrupts (safe setup)

    jal     CONFIG_TIMER        # configure Timer peripheral
    jal     CONFIG_KEYS         # configure Pushbutton peripheral

    # --- Enable interrupt sources IRQ16 (timer) + IRQ18 (pushbuttons) ---
    li      t0, 0x00050000      # bit 16 + bit 18 set
    csrw    mie, t0             # enable those interrupt lines in mie

    # --- Set the interrupt handler address ---
    la      t0, interrupt_handler
    csrw    mtvec, t0

    # --- Re-enable global interrupt bit ---
    li      t0, 0x8             # MIE (machine interrupt enable = bit 3)
    csrw    mstatus, t0
	
	la s0, LEDs
	la s1, COUNT
	LOOP:
		lw     s2, 0(s1)          # Get current count
		sw     s2, 0(s0)          # Store count in LEDs
	j      LOOP



interrupt_handler:
    # --- Save registers ---
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    # --- Read cause ---
    csrr s0, mcause

    # --- Branch to correct ISR ---
    li s1, 0x80000010 #bit 31 is 1 to say it was interupt where as 30:0 bit is number in binarry 16 to respresent what caused interupt 
    beq s0, s1, TIMER_ISR_CALL
    li s1, 0x80000012
    beq s0, s1, KEYS_ISR_CALL

    # --- Restore registers and return if no match ---
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    
	mret

TIMER_ISR_CALL:               # timer caused the interrupt
    # --- Load COUNT ---
    la t1, COUNT
    lw t0, 0(t1)

    # --- Load RUN ---
    la t2, RUN
    lw t3, 0(t2)          # RUN = 0 or 1

    # --- Increment COUNT if RUN = 1 ---
    add t0, t0, t3
    li t4, 255
    blt t0, t4, CONTINUE
    li t0, 0               # reset after 255
CONTINUE:
    sw t0, 0(t1)

    # --- Clear timer interrupt ---
    li t0, 0x1
    li t1, TIMER
    sw t0, 0(t1)

    mret

KEYS_ISR_CALL:                   # Pushbutton caused the interrupt, handle it here
	
    # --- Toggle RUN variable ---
    la t1, RUN                   # Load address of RUN variable
    lw t0, 0(t1)                 # Load current value of RUN (1 = counting, 0 = paused)
    xori t0, t0, 1               # Toggle RUN: 0 ↔ 1
    sw t0, 0(t1)                 # Store new RUN value back to memory

    # --- Clear edge-capture bits (0–3) to acknowledge interrupt ---
    li t0, 0xF                    # 0b1111 → bits 0–3 correspond to keys 0–3
    li t1, PUSH_BUTTON            # Load base address of pushbutton peripheral
    sw t0, 12(t1)               # Write 1s to edge-capture register to clear pending interrupts

    # --- Return from interrupt ---
    mret                          # Return to the main program / previous state


CONFIG_TIMER: 
	# Load start value
    li t0, 25000000       # low 32 bits
    sw t0, 0x8(t1)        # counter start low
    li t0, 0              # high 32 bits
    sw t0, 0xC(t1)        # counter start high he hardware automatically counts down from the start value to 0.
	# When it reaches 0: It sets the status register bit = 1 (interrupt pending)
	# If continuous mode is set, it reloads the start value and continues counting CPU sees interrupt → jumps to handler → you clear the status bit → done

	li t1, TIMER
	li t0, 0b111 #start, contiune, allow interrupt
	sw, t0, 4(t1)
jr ra


CONFIG_KEYS:
    li t1, PUSH_BUTTON       # base address = 0xFF200050

    # 1. Clear edge capture bits (write 1s to clear)
    li t0, 0xF               # bits 0–3 = 1111 (clear all)
    sw t0, 12(t1)           # 0x50 + 0x0C = 0x5C → edge-capture register

    # 2. Enable interrupts for all 4 keys
    li t0, 0xF               # enable interrupts for KEY0–KEY3
    sw t0, 8(t1)           # 0x50 + 0x08 = 0x58 → interrupt mask

jr ra

.data
/* Global variables */
.global  COUNT
COUNT:  .word    0x0            # used by timer
.global  RUN                    # used by pushbutton KEYs
RUN:    .word    0x1            # initial value to increment COUNT
.end
