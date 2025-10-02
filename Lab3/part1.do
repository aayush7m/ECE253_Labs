vlib work
vlog full_adder.sv part1.sv
vsim part1
log {/}
add wave {/}

---- Test 1: a=0000, b=0000, c_in=0 ----
force {a[0]} 0
force {a[1]} 0
force {a[2]} 0
force {a[3]} 0
force {b[0]} 0
force {b[1]} 0
force {b[2]} 0
force {b[3]} 0
force {c_in} 0
run 10ns

---- Test 2: a=0101 (5), b=0011 (3), c_in=0 ----
force {a[0]} 1
force {a[1]} 0
force {a[2]} 1
force {a[3]} 0
force {b[0]} 1
force {b[1]} 1
force {b[2]} 0
force {b[3]} 0
force {c_in} 0
run 10ns

---- Test 3: a=1111 (15), b=0001 (1), c_in=0 ----
force {a[0]} 1
force {a[1]} 1
force {a[2]} 1
force {a[3]} 1
force {b[0]} 1
force {b[1]} 0
force {b[2]} 0
force {b[3]} 0
force {c_in} 0
run 10ns

---- Test 4: a=1001 (9), b=0111 (7), c_in=1 ----
force {a[0]} 1
force {a[1]} 0
force {a[2]} 0
force {a[3]} 1
force {b[0]} 1
force {b[1]} 1
force {b[2]} 1
force {b[3]} 0
force {c_in} 1
run 10ns



