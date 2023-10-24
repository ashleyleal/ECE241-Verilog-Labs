#set working dir, where all compiled verilog goes
vlib work

# Compile Verilog files
vlog part2.v

# Simulate the design
vsim RateDivider

log {/*}
add wave {/*}

# create clock
force {}


# Test case 1: 
    # ClockIn = 100 Hz
    # Reset = 0
    # Speed = 2'b11
# Expected: enable generated every 25hz (to check if enable toggled according to speed)




# Test case 2: 
    # ClockIn = 100 Hz
    # Reset = variable (reset every 5ns)
    # Speed = 2'b00
# Expected: 



run 10ns