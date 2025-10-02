# create working library
vlib work

# compile all needed modules
vlog part1.sv part2.sv

# load simulation with part2 as top-level
vsim work.part2

# log all signals
log -r /*
add wave -r /*

# apply inputs
force A 4'b1100
force B 4'b1010

# Function = 00 (addition)
force Function 2'b00
run 10ns

# Function = 01 (any-bit-set)
force Function 2'b01
run 10ns

# Function = 10 (all-bits-set)
force Function 2'b10
run 10ns

# Function = 11 (concatenation)
force Function 2'b11
run 10ns


