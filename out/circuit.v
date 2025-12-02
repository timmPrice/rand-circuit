module circuit (
    input wire  [4:0] in,
    output wire [4:0] out
);

  wire x0 = in[0];
  wire x1 = in[1];
  wire x2 = in[2];
  wire x3 = in[3];
  wire x4 = in[4];

wire r3 = 1'b1;
  wire r0 = (x2 == 1) && (x4 == 1);
  wire r1 = (x2 == 0) && (x4 == 0);
  wire r2 = (x2 == 0);

  assign out[0] = r1;
  assign out[1] = r3;
  assign out[2] = r0;
  assign out[3] = r2;
  assign out[4] = 1'b0;

endmodule
