module part1 (input Clock, input Enable, input Reset, output [7:0] CounterValue);

    wire t0, t1, t2, t3, t4, t5, t6, t7;
    reg [7:0] counters;
    
    assign t0 = Enable;

    TFlipFlop tff0 (
        .T(t0),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[0])
    );

    assign t1 = Enable & counters[0];
    
    TFlipFlop tff1 (
        .T(t1),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[1])
    );
    
    TFlipFlop tff2 (
        .T(t2),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[2])
    );
    
    TFlipFlop tff3 (
        .T(t3),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[3])
    );
    
    TFlipFlop tff4 (
        .T(t4),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[4])
    );
    
    TFlipFlop tff5 (
        .T(t5),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[5])
    );
    
    TFlipFlop tff6 (
        .T(t6),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[6])
    );
    
    TFlipFlop tff7 (
        .T(t7),
        .Clock(Clock),
        .Reset(Reset),
        .q(counters[7])
    );
    
    assign CounterValue = counters;
    
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
            q <= ~q;
        end
endmodule