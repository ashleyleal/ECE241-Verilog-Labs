module part1 (input Clock, input Enable, input Reset, output [7:0] CounterValue);

endmodule


module TFlipFlop (
    input wire T,
    input wire Clock,
    input wire Reset,
    output reg q
);
    always @(posedge Clock)
        begin
        if (!Reset)
            q <= 0;
        else if (T)
            Q <= ~Q;
        end
endmodule