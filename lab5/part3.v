module part3
#(parameter CLOCK_FREQUENCY=50000000)(
input wire ClockIn,
input wire Reset,
input wire Start,
input wire [2:0] Letter,
output wire DotDashOut,
output wire NewBitOut
);

	//Morse Encoder here
	

endmodule


module ShiftReg(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input wire clock, reset;
	input ParallelLoadn, RotateRight, ASRight;
	input [3:0] Data_IN;
	output [3:0] Q;
	reg [3:0] pre_reg_Q;

	always@(posedge clock)
	begin
		if (reset)
		begin
			pre_reg_Q[0] <= 4'b0000;
			pre_reg_Q[1] <= 4'b0000;
			pre_reg_Q[2] <= 4'b0000;
			pre_reg_Q[3] <= 4'b0000;
		end
		else if (ParallelLoadn == 0)
		begin
			pre_reg_Q[0] <= Data_IN[0];
			pre_reg_Q[1] <= Data_IN[1];
			pre_reg_Q[2] <= Data_IN[2];
			pre_reg_Q[3] <= Data_IN[3];		
		end
		else if (ParallelLoadn == 1 && RotateRight == 1 && ASRight == 0)
		begin
			pre_reg_Q[0] <= pre_reg_Q[1];
			pre_reg_Q[1] <= pre_reg_Q[2];
			pre_reg_Q[2] <= pre_reg_Q[3];
			pre_reg_Q[3] <= pre_reg_Q[0];
		end
		else if (ParallelLoadn == 1 && RotateRight == 1 && ASRight == 1)
		begin
			pre_reg_Q[0] <= pre_reg_Q[1];
			pre_reg_Q[1] <= pre_reg_Q[2];
			pre_reg_Q[2] <= pre_reg_Q[3];
			pre_reg_Q[3] <= pre_reg_Q[3];
		end
		else if (ParallelLoadn == 1 && RotateRight == 0)	
		begin
			pre_reg_Q[0] <= pre_reg_Q[3];
			pre_reg_Q[1] <= pre_reg_Q[2];
			pre_reg_Q[2] <= pre_reg_Q[1];
			pre_reg_Q[3] <= pre_reg_Q[0];
		end
	end
	assign Q = pre_reg_Q;
endmodule


// Morse Code LUT
module MorseLUT(input[2:0] s, output reg[11:0] q);
	always@(*)
		case(s)
			3'b000: q = {16'b101110000000};//A
			3'b001: q = {16'b111010101000};//B
			3'b010: q = {16'b111010111010};//C
			3'b011: q = {16'b111010100000};//D
			3'b100: q = {16'b100000000000};//E
			3'b101: q = {16'b101011101000};//F
			3'b110: q = {16'b111011101000};//G
			3'b111: q = {16'b101010100000};//H
			default: q = 16'b000000000000;
		endcase
endmodule;

// Rate Divider Module takes a fast clock signal and divides its frequency to generate a slower pulse signal, enabling the DisplayCounter to update its value at controlled intervals
module RateDivider #(
    parameter CLOCK_FREQUENCY = 50000000
) (
    input ClockIn,
    input Reset,
    input [1:0] Speed,
    output reg Enable
);
 reg [26:0] downCount;
 always @(posedge ClockIn)
	begin
		if ((Reset == 1'b1) || (downCount == 27'd0)) begin
			if (speed == 1'b0)
				downCount <= 27'd50000000;
			else
				downCount <= 27'd100000000;
			end
		else begin
			downCount <= downCount - 1b'1;
		end
	end
	assign enable = (downCount == 27'd0) ? 1'b1

endmodule

// Notes:

// Required Modules:
	// 12(?)bit Rate Divider
	// Shift Register
	// Morse LUT (not required but helpful)
	// Morse encoder (Top Level Module)
