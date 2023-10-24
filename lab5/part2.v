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

// Rate Divider Module: takes a fast clock signal and divides its frequency to generate a slower pulse signal, enabling the DisplayCounter to update its value at controlled intervals
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

// Display Counter Module:  keeps track of a 4-bit value, continuously incrementing it when the RateDivider provides the enabling signal (EnableDC)
// The CounterValue provides a continuous stream of hexadecimal values from 0 to F, reflecting the current count state of the counter
module DisplayCounter (
    input Clock,
    input Reset,
    input EnableDC,
    output [3:0] CounterValue
);


endmodule

// Hex Display Module
module hex_display(
    input [3:0] hex, 
    output reg [6:0] display
);
always @(*)
    begin
    case(hex_input)

        4'h0: display = 7'b1000000; // 0
        4'h1: display = 7'b1111001; // 1
        4'h2: display = 7'b0100100; // 2
        4'h3: display = 7'b0110000; // 3
        4'h4: display = 7'b0011001; // 4
        4'h5: display = 7'b0010010; // 5
        4'h6: display = 7'b0000010; // 6
        4'h7: display = 7'b1111000; // 7
        4'h8: display = 7'b0000000; // 8
        4'h9: display = 7'b0010000; // 9
        4'ha: display = 7'b0001000; // A
        4'hb: display = 7'b0000011; // B
        4'hc: display = 7'b1000110; // C
        4'hd: display = 7'b0100001; // D
        4'he: display = 7'b0000110; // E
        4'hf: display = 7'b0001110; // F
        default: display = 7'b1111111; // Display nothing
    endcase
end
endmodule