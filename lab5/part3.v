module part3 #(
    parameter CLOCK_FREQUENCY = 50000000
) (
    input wire ClockIn,  // clock
    input wire Reset,  // reset
    input wire Start,  // 
    input wire [2:0] Letter,  //mux select
    output wire DotDashOut,
    output wire NewBitOut
);

  //Morse Encoder here
  wire [11:0] MorseCode;
  wire [11:0] RegOut;

  MorseLUT LUTInst (
      .s(Letter),
      .q(MorseCode)
  );

  RateDivider #(
      .CLOCK_FREQUENCY(CLOCK_FREQUENCY)
  ) RDInst (
      .ClockIn(ClockIn),
      .Reset  (Reset),
      .Enable (Start)
  );

  ShiftReg12Bit RegInst (
      .clock(ClockIn),
      .reset(Reset),
      .ParallelLoadn(Start),
      .RotateRight(NewBitOut),
      .ASRight(DotDashOut),
      .Data_IN(MorseCode),
      .Q(RegOut)
  );

endmodule


module ShiftReg12Bit (
    clock,
    reset,
    ParallelLoadn,
    RotateRight,
    ASRight,
    Data_IN,
    Q
);
  input wire clock, reset;
  input ParallelLoadn, RotateRight, ASRight;
  input [11:0] Data_IN;
  output [11:0] Q;
  reg [11:0] pre_reg_Q;

  always @(posedge clock) begin
    if (reset) begin
      pre_reg_Q[0]  <= 12'b0;
      pre_reg_Q[1]  <= 12'b0;
      pre_reg_Q[2]  <= 12'b0;
      pre_reg_Q[3]  <= 12'b0;
      pre_reg_Q[4]  <= 12'b0;
      pre_reg_Q[5]  <= 12'b0;
      pre_reg_Q[6]  <= 12'b0;
      pre_reg_Q[7]  <= 12'b0;
      pre_reg_Q[8]  <= 12'b0;
      pre_reg_Q[9]  <= 12'b0;
      pre_reg_Q[10] <= 12'b0;
      pre_reg_Q[11] <= 12'b0;
    end else if (ParallelLoadn == 0) begin
      pre_reg_Q[0]  <= Data_IN[0];
      pre_reg_Q[1]  <= Data_IN[1];
      pre_reg_Q[2]  <= Data_IN[2];
      pre_reg_Q[3]  <= Data_IN[3];
      pre_reg_Q[4]  <= Data_IN[4];
      pre_reg_Q[5]  <= Data_IN[5];
      pre_reg_Q[6]  <= Data_IN[6];
      pre_reg_Q[7]  <= Data_IN[7];
      pre_reg_Q[8]  <= Data_IN[8];
      pre_reg_Q[9]  <= Data_IN[9];
      pre_reg_Q[10] <= Data_IN[10];
      pre_reg_Q[11] <= Data_IN[11];
    end else if (ParallelLoadn == 1 && RotateRight == 1 && ASRight == 0) begin
      pre_reg_Q[0]  <= pre_reg_Q[1];
      pre_reg_Q[1]  <= pre_reg_Q[2];
      pre_reg_Q[2]  <= pre_reg_Q[3];
      pre_reg_Q[3]  <= pre_reg_Q[4];
      pre_reg_Q[4]  <= pre_reg_Q[5];
      pre_reg_Q[5]  <= pre_reg_Q[6];
      pre_reg_Q[6]  <= pre_reg_Q[7];
      pre_reg_Q[7]  <= pre_reg_Q[8];
      pre_reg_Q[8]  <= pre_reg_Q[9];
      pre_reg_Q[9]  <= pre_reg_Q[10];
      pre_reg_Q[10] <= pre_reg_Q[11];
      pre_reg_Q[11] <= pre_reg_Q[0];
    end else if (ParallelLoadn == 1 && RotateRight == 1 && ASRight == 1) begin
      pre_reg_Q[0]  <= pre_reg_Q[1];
      pre_reg_Q[1]  <= pre_reg_Q[2];
      pre_reg_Q[2]  <= pre_reg_Q[3];
      pre_reg_Q[3]  <= pre_reg_Q[4];
      pre_reg_Q[4]  <= pre_reg_Q[5];
      pre_reg_Q[5]  <= pre_reg_Q[6];
      pre_reg_Q[6]  <= pre_reg_Q[7];
      pre_reg_Q[7]  <= pre_reg_Q[8];
      pre_reg_Q[8]  <= pre_reg_Q[9];
      pre_reg_Q[9]  <= pre_reg_Q[10];
      pre_reg_Q[10] <= pre_reg_Q[11];
      pre_reg_Q[11] <= pre_reg_Q[0];
    end else if (ParallelLoadn == 1 && RotateRight == 0) begin
      pre_reg_Q[0]  <= Data_IN[11];
      pre_reg_Q[1]  <= Data_IN[10];
      pre_reg_Q[2]  <= Data_IN[9];
      pre_reg_Q[3]  <= Data_IN[8];
      pre_reg_Q[4]  <= Data_IN[7];
      pre_reg_Q[5]  <= Data_IN[6];
      pre_reg_Q[6]  <= Data_IN[5];
      pre_reg_Q[7]  <= Data_IN[4];
      pre_reg_Q[8]  <= Data_IN[3];
      pre_reg_Q[9]  <= Data_IN[2];
      pre_reg_Q[10] <= Data_IN[1];
      pre_reg_Q[11] <= Data_IN[0];
    end
  end
  assign Q = pre_reg_Q;
endmodule

module MorseLUT (
    input [2:0] s,
    output reg [11:0] q
);
  always @(*)
    case (s)
      3'b000:  q = {12'b101110000000};  //A
      3'b001:  q = {12'b111010101000};  //B
      3'b010:  q = {12'b111010111010};  //C
      3'b011:  q = {12'b111010100000};  //D
      3'b100:  q = {12'b100000000000};  //E
      3'b101:  q = {12'b101011101000};  //F
      3'b110:  q = {12'b111011101000};  //G
      3'b111:  q = {12'b101010100000};  //H
    endcase
endmodule
;

module RateDivider #(
    parameter CLOCK_FREQUENCY = 50000000
) (
    input ClockIn,
    input Reset,
    output Enable
);

  reg [31:0] maxCount;
  reg [31:0] counter;

  always @(posedge ClockIn) begin
    if (Reset) begin
      // reset counter to 0 on reset, keep enable to low 
      counter <= maxCount;
      maxCount = CLOCK_FREQUENCY / 2 - 1;
    end

    if (counter != 32'b0) begin
      counter <= counter - 1;
    end else begin
      maxCount = CLOCK_FREQUENCY / 2 - 1;
      counter <= maxCount;
    end
  end

  assign Enable = (counter == 0) ? 1'b1 : 1'b0;

endmodule

