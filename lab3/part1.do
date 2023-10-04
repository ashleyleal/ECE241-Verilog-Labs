#set working dir, where all compiled verilog goes
vlib work

# Compile Verilog files
vlog part1.v

# Simulate the design
vsim part1 // errors here for some reason

log {/*}

# Test case 1: both input and carry in are 0
# Expectation: carry out and sum are 0
# Objective: ensure no unexpected inverted output

# input a
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

# input b
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

# carry in
force {SW[8]} 0

run 10ns