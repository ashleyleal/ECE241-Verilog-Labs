// A input is Data
// B input is the 4 least significant bits of ALUout

module part2(Clock, Reset_b, Data, Function, ALUout);
    
	 input wire Clock, Reset_b, 
    input [3:0] Data, 
    input [1:0] Function,
    output reg [7:0] ALUout

	 reg [7:0] Pre_reg_ALUout;
	 
	 
    always@(*)
    begin
	 
	 8_bit_register 8_reg (Clock, Reset_b, )
	 
	 A <= Data;
	 B <= 
	 
    case (Function)
        2'b00: Pre_reg_ALUout <= A + B 
        2'b01: Pre_reg_ALUout <= A * B
        2'b10: Pre_reg_ALUout <= B <<< 4
        2'b11: Pre_reg_ALUout <= B 
        default: 8'b00000000
    endcase
    end

endmodule

module 8_bit_register (
	input wire clk ,
	input wire reset_b ,
	input wire [7:0]d ,
	output reg[7:0] q);
	
always@ ( posedge clk )
begin
	if ( reset_b ) q <= 1 ’ b0 ;
	else q <= d ;
end
endmodule


