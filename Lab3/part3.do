# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim work.part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# set Data[3:0] = 1100
force Data[0] 0
force Data[1] 0
force Data[2] 1
force Data[3] 1


force Function[0] 0
force Function[1] 0
force Function[2] 0

# create a clock with 10ns period
force Clock 0
run 5ns
force Clock 1
run 5ns
force Clock 0
run 5ns
force Clock 1
run 5ns

force Reset_b 1
run 10ns   # assert reset for a few cycles
force Reset_b 0

# run for 10ns
run 10ns

