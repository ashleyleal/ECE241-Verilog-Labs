module part2
#(parameter CLOCK_FREQUENCY = 50000000)(
input ClockIn,
input Reset,
input [1:0] Speed,
output [3:0] CounterValue
);
