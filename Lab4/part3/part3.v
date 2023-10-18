// Failing some test cases:

module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
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

