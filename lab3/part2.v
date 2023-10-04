/* Lab 3 Part 2 */

module part2( input [3:0] a, input [3:0] b, input Function, output [7:0] ALUout );

    // Instantiate each function outside of the always block
    fourBitRippleCarryAdder function0 (.a(), .b(), .c_in(), .c_out(), .s());
    singleReductionOR function1 (.a(), .b(), .ab());
    singleReductionAND function2 (.a(), .b(), .ab());
    concatenation function3 (.a(), .b(), .ab());

    always @ (a, b) begin
        case(Function)

        2'b00 : assign ALUout = function0 (); // output sum of RCA
        2'b01 : assign ALUout = function1; // output 8'b00000001 if a or b
        2'b10 : assign ALUout = function2; // output 8'b00000001 if a and b
        3'b11 : assign ALUout = function3; // output a concat b

        endcase
    end
endmodule

// Full adder module for function 0

module fullAdder( input c_in, a, b, output c_out, s );

	assign s = (a ^ b) ^ c_in; // XOR 
	assign c_out = (a & b) | (b & c_in) | (a & c_in);

endmodule // fullAdder

// Function 0: Four Bit Ripple Carry Adder Module

module fourBitRippleCarryAdder( input [3:0] a, input [3:0] b, input c_in, output c_out, output [3:0] s );

	wire[2:0] c; 
	
    fullAdder bit0 (.c_in(c_in), .a(a[0]), .b(b[0]), .c_out(c[0]), .s(s[0]));
    fullAdder bit1 (.c_in(c[0]), .a(a[1]), .b(b[1]), .c_out(c[1]), .s(s[1]));
    fullAdder bit2 (.c_in(c[1]), .a(a[2]), .b(b[2]), .c_out(c[2]), .s(s[2]));
    fullAdder bit3 (.c_in(c[2]), .a(a[3]), .b(b[3]), .c_out(c_out), .s(s[3]));
	
endmodule // fourBitRippleCarryAdder

// Function 1: Single reduction (bitwise) OR

module singleReductionOR ( input [3:0] a, input [3:0] b, output [7:0] ab);
    
    assign ab = a | b ? 8'b00000001;

endmodule

// Function 2: Single reduction (bitwise) AND

module singleReductionAND ( input [3:0] a, input [3:0] b, output [7:0] ab);
    
    assign ab = a & b ? 8'b00000001;

endmodule

// Function 3: A most significant 4 bits, B lower 4 bits

module concatenation( input [3:0] a, input [3:0] b, output [7:0] ab);

    assign ab = {a, b};

endmodule