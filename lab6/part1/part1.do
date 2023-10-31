#set working dir, where all compiled verilog goes
vlib work

# Compile Verilog files
vlog part1demo.v

# Simulate the design
vsim Lab6

log {/*}
add wave {/*}

# KEY[0] Clock
# SW[1] w
# SW[0] Reset

# Reset
force {SW[0]} 1
force {KEY[0]} 1
run 5ns
force {SW[0]} 0
force {KEY[0]} 0
run 5ns

# Test case 1: State A to State F
# Expected output: 1
# w = 1 1 1 1

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

# Reset
force {SW[0]} 1
force {KEY[0]} 1
run 5ns
force {SW[0]} 0
force {KEY[0]} 0
run 5ns

# Test case 2: State A to State G
# Expected output: 1
# w = 1 1 0 1

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 0
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

# Reset
force {SW[0]} 1
force {KEY[0]} 1
run 5ns
force {SW[0]} 0
force {KEY[0]} 0
run 5ns

# Test case 3: State A to State A
# Expected output: 0
# w = 0 0 0 

force {SW[1:0]} 01
force {KEY[0]} 0
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 0
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 0
run 5ns

# Reset
force {SW[0]} 1
force {KEY[0]} 1
run 5ns
force {SW[0]} 0
force {KEY[0]} 0
run 5ns

# Test case 4: State F to State G
# Expected output: 1
# w = 1 1 1 1 0 1

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 0
run 5ns

force {SW[1:0]} 01
force {KEY[0]} 1
run 5ns