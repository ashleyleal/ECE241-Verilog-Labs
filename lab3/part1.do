#set working dir, where all compiled verilog goes
vlib work

# Compile Verilog files
vlog part1.v

# Simulate the design
vsim part1

log {/*}
add wave {/*}

# Test case 1: both inputs and carry in are 0
# Expectation: carry out and sum are 0
# Objective: ensure no unexpected inverted output

# input a
force {a[7]} 0
force {a[6]} 0
force {a[5]} 0
force {a[4]} 0

# input b
force {b[3]} 0
force {b[2]} 0
force {b[1]} 0
force {b[0]} 0

# carry in
force {c_in} 0

run 10ns

# Test case 2: both inputs and carry in are 1
# Expectation: carry out and sum are 1
# Objective: check if carry outs work as expected

# input a
force {a[7]} 1
force {a[6]} 1
force {a[5]} 1
force {a[4]} 1

# input b
force {b[3]} 1
force {b[2]} 1
force {b[1]} 1
force {bSW[0]} 1

# carry in
force {c_in} 1

run 10ns
