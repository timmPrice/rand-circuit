module circuit (
    input wire  [4:0] in,
    output wire [4:0] out
);

wire x0 = in[0];
wire x1 = in[1];
wire x2 = in[2];
wire x3 = in[3];
wire x4 = in[4];

wire r0 = (x0 == 1)(x2 == 0);
wire r1 = (x0 == 0)(x2 == 1);
wire r2 = (x0 == 0);

endmodule
