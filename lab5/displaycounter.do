#set working dir, where all compiled verilog goes
vlib work

# Compile Verilog files
vlog part2.v

# Simulate the design
vsim DisplayCounter

log {/*}
add wave {/*}

run 10ns