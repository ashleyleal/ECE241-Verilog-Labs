// All Test Cases Passed!

module part2(Clock, Reset_b, Data, Function, ALUout);
    
	input wire Clock, Reset_b; 
	input [3:0] Data; 
	input [1:0] Function;
	output[7:0] ALUout;

	reg [7:0] Pre_reg_ALUout;

	always@(posedge Clock)
	begin
	if (Reset_b)
		begin
			Pre_reg_ALUout <= 8'b00000000;
		end
	else
		begin
			case (Function)
			  2'b00: Pre_reg_ALUout <= Data + Pre_reg_ALUout[3:0]; 
			  2'b01: Pre_reg_ALUout <= Data * Pre_reg_ALUout[3:0];
			  2'b10: Pre_reg_ALUout <= Pre_reg_ALUout[3:0] << Data;
			  2'b11: ; 
			  default: Pre_reg_ALUout <= 8'b00000000;
			endcase
		end
	end
	 assign ALUout = Pre_reg_ALUout;
	 
endmodule
