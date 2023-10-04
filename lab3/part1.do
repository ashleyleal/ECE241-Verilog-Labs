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

# Test case 2: both inputs and carry in are 1
# Expectation: carry out and sum are 1
# Objective: check if carry outs work as expected

# input a
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1

# input b
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

# carry in
force {SW[8]} 1

run 10ns
