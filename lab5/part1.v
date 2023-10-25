module part1 (input Clock, input Enable, input Reset, output [7:0] CounterValue);

    wire t0, t1, t2, t3, t4, t5, t6, t7;
    reg [7:0] counter_values;
    
    TFlipFlop tff0 (
        .T(t0),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[0])
    );
    
    TFlipFlop tff1 (
        .T(t1),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[1])
    );
    
    TFlipFlop tff2 (
        .T(t2),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[2])
    );
    
    TFlipFlop tff3 (
        .T(t3),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[3])
    );
    
    TFlipFlop tff4 (
        .T(t4),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[4])
    );
    
    TFlipFlop tff5 (
        .T(t5),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[5])
    );
    
    TFlipFlop tff6 (
        .T(t6),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[6])
    );
    
    TFlipFlop tff7 (
        .T(t7),
        .Clock(Clock),
        .Reset(Reset),
        .q(counter_values[7])
    );
    
    assign CounterValue = counter_values;
    
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