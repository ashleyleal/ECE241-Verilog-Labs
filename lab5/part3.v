module part3
#(parameter CLOCK_FREQUENCY=50000000)(
input wire ClockIn,
input wire Reset,
input wire Start,
input wire [2:0] Letter,
output wire DotDashOut,
output wire NewBitOut
);
