module circuit (
    input wire  [4:0] in,
    output wire [4:0] out
);

  wire x0 = in[0];
  wire x1 = in[1];
  wire x2 = in[2];
  wire x3 = in[3];
  wire x4 = in[4];

  wire r0 = (x0 == 0) && (x1 == 0) && (x4 == 0);
  wire r1 = (x0 == 0) && (x2 == 1) && (x3 == 0);
  wire r2 = (x0 == 0) && (x3 == 0) && (x4 == 0);
  wire r3 = (x0 == 0) && (x4 == 1);
  wire r4 = (x1 == 0) && (x3 == 1);
  wire r5 = (x2 == 1);
  wire r6 = (x1 == 1);
  wire r7 = (x0 == 0) && (x4 == 0);

endmodule
