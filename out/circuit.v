module circuit (
    input wire  [4:0] in,
    output wire [4:0] out
);

  wire x0 = in[0];
  wire x1 = in[1];
  wire x2 = in[2];
  wire x3 = in[3];
  wire x4 = in[4];

  wire r0 = (x1 == 1) && (x4 == 0);
  wire r1 = (x0 == 0) && (x2 == 1);
  wire r2 = (x0 == 1) && (x1 == 0) && (x2 == 1);
  wire r3 = (x1 == 0) && (x2 == 0);
  wire r4 = (x4 == 1);
  wire r5 = (x1 == 1);
  wire r6 = (x0 == 0);

  assign out[0] = r2 | r4 | r6;
  assign out[1] = r2 | r3;
  assign out[2] = r2 | r3 | r5;
  assign out[3] = r0 | r6;
  assign out[4] = r1;

endmodule
