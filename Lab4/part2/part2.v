module part2(Clock, Reset_b, Data, Function, ALUout);
    input wire Clock, Reset_b, 
    input [3:0] Data, 
    input [1:0] Function,
    output reg [7:0] ALUout

    always@(*)
    begin
    case (Function)
        2'b00: 
        2'b01:
        2'b10:
        2'b11:
        default: 
    endcase
    end

endmodule

