#set working dir, where all compiled verilog goes
vlib work

# Compile Verilog files
vlog part2.v

# Simulate the design
vsim part2

log {/*}
add wave {/*}

force {Clock} 0 0ns, 1 {100ps} -r 200ps
force {Reset} 0 0ns, 1 {95ps}
force {Reset} 0 295ps
# a = 2, b = 3, c = 6, x = 5
force {Go} 1 1050ps, 0 {1250ps}
force {DataIn} 0000010 1050ps
force {Go} 1 1450ps, 0 {1650ps}
force {DataIn} 0000011 1450ps
force {Go} 1 1850ps, 0 {2050ps}
force {DataIn} 0000111 1850ps
force {Go} 1 2250ps, 0 {2450ps}
force {DataIn} 0000101 2250ps
force {Reset} 1 4250ps, 0 {4450ps}
# a = 0, b = 0, c = 0, x = 0
force {Go} 1 4650ps, 0 {4850ps}
force {DataIn} 0000000 4650ps
force {Go} 1 5050ps, 0 {5250ps}
force {DataIn} 0000000 5050ps
force {Go} 1 5450ps, 0 {5650ps}
force {DataIn} 0000000 5450ps
force {Go} 1 5850ps, 0 {6050ps}
force {DataIn} 0000000 5850ps
force {Reset} 1 6850ps
# reset on
force {Go} 1 7050ps, 0 {7250ps}
force {DataIn} 0000010 7050ps
force {Go} 1 7450ps, 0 {7650ps}
force {DataIn} 0000011 7450ps
force {Go} 1 7850ps, 0 {8050ps}
force {DataIn} 0000111 7850ps
force {Go} 1 8250ps, 0 {8450ps}
force {DataIn} 0000101 8250ps
run 10ns
