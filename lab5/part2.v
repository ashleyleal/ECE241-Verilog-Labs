// Top Level Module
module part2 #(
    parameter CLOCK_FREQUENCY = 50000000
) (
    input ClockIn,
    input Reset,
    input [1:0] Speed,
    output [3:0] CounterValue
);
  wire EnableDC;

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

// 	// Hex Decoder
// 	HexDecoder HexInst (
//      .hex(CounterValue), .display(HEX0)  
//    );

endmodule

// Rate Divider Module takes a fast clock signal and divides its frequency to generate a slower pulse signal, enabling the DisplayCounter to update its value at controlled intervals
module RateDivider #(
    parameter CLOCK_FREQUENCY = 50000000
) (
    input ClockIn,
    input Reset,
    input [1:0] Speed,
    output Enable
);
    // Automatically find minimum number of bits for clock frequency (flexibility)
    // counter
    reg [31:0] maxCount;
    reg [31:0] counter; 

	always @(posedge ClockIn) begin
        if (Reset) begin
            // reset counter to 0 on reset, keep enable to low 
            counter <= maxCount;
				case(Speed)
                // Full speed (once every clock period)
                2'b00: maxCount = 32'b0; 
                // 1 Hz (once a second)
                2'b01: maxCount = CLOCK_FREQUENCY - 1; 
                // 0.5 Hz (once every 2 seconds)
                2'b10: maxCount = CLOCK_FREQUENCY * 2 - 1;
                // 0.25 Hz (once every 4 sec)
                2'b11: maxCount = CLOCK_FREQUENCY * 4 - 1; 
            endcase
            counter <= maxCount;
        end

        if(counter != 32'b0) begin
            counter <= counter - 1;
        end

        else begin
        		case(Speed)
                // Full speed (once every clock period)
                2'b00: maxCount = 0; 
                // 1 Hz (once a second)
                2'b01: maxCount = CLOCK_FREQUENCY - 1; 
                // 0.5 Hz (once every 2 seconds)
                2'b10: maxCount = CLOCK_FREQUENCY * 2 - 1;
                // 0.25 Hz (once every 4 sec)
                2'b11: maxCount = CLOCK_FREQUENCY * 4 - 1; 
            endcase
            counter <= maxCount;
        end
    end

    assign Enable = (counter == 0) ? 1'b1 : 1'b0;

endmodule

// Display Counter Module keeps track of a 4-bit value and increments it when the RateDivider provides EnableDC; provides a continuous stream of hexadecimal values matching the current count state of the counter to show on display
module DisplayCounter (
    input Clock,
    input Reset,
    input EnableDC,
    // 4 for hexadecimal
    output reg [3:0] CounterValue
);
    always @(posedge Clock)
    begin
        if (Reset == 1'b1) begin
            CounterValue <= 4'b0;
        end
        else if (EnableDC == 1'b1) begin
            CounterValue <= CounterValue + 1;
        end
    end
endmodule

// Hex Display Module
module HexDecoder(
    input [3:0] hex, 
    output reg [6:0] display
);
always @(*)
    begin
    case(hex)
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
