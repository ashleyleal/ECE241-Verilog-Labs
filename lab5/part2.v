// Top Level Module
module part2 #(
    parameter CLOCK_FREQUENCY = 50000000
) (
    input ClockIn,
    input Reset,
    input [1:0] Speed,
    output [3:0] CounterValue
);

  reg EnableDC;


  // Instantiate Rate Divider
  RateDivider #(
      .CLOCK_FREQUENCY(CLOCK_FREQUENCY)
  ) RDInst (
      .ClockIn(ClockIn),
      .Reset  (Reset),
      .Speed  (Speed),
      .Enable (EnableDC)
  );

  // Instantiate Display Counter
  DisplayCounter DCInst (
      .Clock(ClockIn),
      .Reset(Reset),
      .EnableDC(EnableDC),
      .CounterValue(CounterValue)
  );

endmodule

// Rate Divider
module RateDivider #(
    parameter CLOCK_FREQUENCY = 50000000
) (
    input ClockIn,
    input Reset,
    input [1:0] Speed,
    output Enable
);

always@(posedge ClockIn, negedge Reset)
	begin
	if (~Reset)
		Enable <= 1'b0;
	else
		Enable <= ~Enable;
	end

endmodule

// Display Counter
module DisplayCounter (
    input Clock,
    input Reset,
    input EnableDC,
    output [3:0] CounterValue
);
endmodule

//
