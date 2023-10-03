/* Lab 3 Part 1 */

// Full adder module
module fullAdder( input c_in, a, b, output c_out, s );

	assign s = (a ^ b) ^ c_in; // XOR 
	assign c_out = (a & b) | (b & c_in) | (a & c_in);

endmodule


// Four Bit Ripple Carry Adder Module
module fourBitRippleCarryAdder( input [3:0] a, input [3:0] b, input c_in, output c_out, output [3:0] s );

	wire[2:0] c; 
	
    fullAdder bit0 (.c_in(c_in), .a(a[0]), .b(b[0]), .c_out(c[0]), .s(s[0]));
    fullAdder bit1 (.c_in(c[0]), .a(a[1]), .b(b[1]), .c_out(c[1]), .s(s[1]));
    fullAdder bit2 (.c_in(c[1]), .a(a[2]), .b(b[2]), .c_out(c[2]), .s(s[2]));
    fullAdder bit3 (.c_in(c[2]), .a(a[3]), .b(b[3]), .c_out(c_out), .s(s[3]));
	
endmodule

// Mapping to FPGA and Instantiating 
module part1(input [8:0] SW, output [9:0] LEDR);

	fourBitRippleCarryAdder ( .a(SW[7:4]), .b(SW[3:0]), .c_in(SW[8]), .c_out(LEDR[9:6]), .s(LEDR[3:0]) );

endmodule
