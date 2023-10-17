// A input is Data
// B input is the 4 least significant bits of ALUout

module part2(Clock, Reset_b, Data, Function, ALUout);
    
	 input wire Clock, Reset_b; 
    input [3:0] Data; 
    input [1:0] Function;
    output[7:0] ALUout;

	 reg [7:0] Pre_reg_ALUout;
	 
	 always@(*)
    begin
	 
    case (Function)
        2'b00: Pre_reg_ALUout <= Data + ALUout; 
        2'b01: Pre_reg_ALUout <= Data * ALUout;
        2'b10: Pre_reg_ALUout <= ALUout << Data;
        2'b11: Pre_reg_ALUout <= ALUout; 
        default: Pre_reg_ALUout <= 8'b00000000;
    endcase
    end
	 
	 eight_bit_register u1 (Clock, Reset_b, Pre_reg_ALUout, ALUout);
	 //assign ALUout = Pre_reg_ALUout;
	 
endmodule


module eight_bit_register (
	input wire clk ,
	input wire reset_b ,
	input wire [7:0]d ,
	output reg[7:0] q);
	
always@ ( posedge clk )
begin
	if ( reset_b ) q <= 1'b0 ;
	else q <= d ;
end
endmodule


