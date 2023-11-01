#set working dir, where all compiled verilog goes
vlib work

# Compile Verilog files
vlog part1.v

# Simulate the design
vsim part1

log {/*}
add wave {/*}

force {Clock} 0 0ns, 1 {100ps} -r 200ps
force {Reset} 0 0ns
# w = 1111 A-F
force {w} 1 0ps 
force {Reset} 1 800ps, 0 {1000ps}
# w = 1101 A-G
force {w} 1 1050ps
force {w} 0 1650ps
force {w} 1 1850ps 
force {Reset} 1 2000ps, 0 {2200ps}
# w = 000 A-A
force {w} 0 2250ps 
force {Reset} 1 2800ps, 0 {3000ps}
# w = 111101 A-F-G
force {w} 1 3050ps
force {w} 0 3850ps
force {w} 1 4050ps 
force {Reset} 1 4200ps
# reset on
force {w} 1 4250ps
force {w} 0 5050ps
force {w} 1 5250ps 
force {Reset} 0 5400ps
run 10ns
