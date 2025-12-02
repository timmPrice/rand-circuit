module circuit (
    input wire  [4:0] in,
    output wire [4:0] out
);

  wire x0 = in[0];
  wire x1 = in[1];
  wire x2 = in[2];
  wire x3 = in[3];
  wire x4 = in[4];

  wire r0 = (x3 == 0) && (x4 == 1);
  wire r1 = (x0 == 0) && (x2 == 0) && (x4 == 0);
  wire r2 = (x1 == 0) && (x2 == 0);
  wire r3 = (x2 == 1);
  wire r4 = (x0 == 1);
  wire r5 = (x0 == 0) && (x2 == 0);

  assign out[0] = r5;
  assign out[1] = r2 | r5;
  assign out[2] = r1;
  assign out[3] = r3 | r4 | r5;
  assign out[4] = r0 | r3 | r4;

endmodule
