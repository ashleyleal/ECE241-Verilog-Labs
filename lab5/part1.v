module part1 (
    input Clock,
    input Enable,
    input Reset,
    output [7:0] CounterValue
);
    wire [6:0] q;
    assign q[0] = Enable & CounterValue[0];
    assign q[1] = q[0] & CounterValue[1];
    assign q[2] = q[1] & CounterValue[2];
    assign q[3] = q[2] & CounterValue[3];
    assign q[4] = q[3] & CounterValue[4];
    assign q[5] = q[4] & CounterValue[5];
    assign q[6] = q[5] & CounterValue[6];

    Tflip u1 (.Clock(Clock), .Enable(Enable), .Reset(Reset), .CounterValue(CounterValue[0]));

    Tflip u2 (.Clock(Clock), .Enable(q[0]), .Reset(Reset), .CounterValue(CounterValue[1]));

    Tflip u3 (.Clock(Clock), .Enable(q[1]), .Reset(Reset), .CounterValue(CounterValue[2]));

    Tflip u4 (.Clock(Clock), .Enable(q[2]), .Reset(Reset), .CounterValue(CounterValue[3]));

    Tflip u5 (.Clock(Clock), .Enable(q[3]), .Reset(Reset), .CounterValue(CounterValue[4]));

    Tflip u6 (.Clock(Clock), .Enable(q[4]), .Reset(Reset), .CounterValue(CounterValue[5]));

    Tflip u7 (.Clock(Clock), .Enable(q[5]), .Reset(Reset), .CounterValue(CounterValue[6]));

    Tflip u8 (.Clock(Clock), .Enable(q[6]), .Reset(Reset), .CounterValue(CounterValue[7]));
endmodule

module Tflip (
    input Clock,
    input Enable,
    input Reset,
    output reg [7:0] CounterValue
);

    always @(posedge Clock, negedge Reset) begin
        if (Reset == 1'b1) begin
            CounterValue <= 8'b0;
        end

        else if (Enable == 1'b1) begin
            CounterValue <= CounterValue ^ Enable;
        end
    end
endmodule