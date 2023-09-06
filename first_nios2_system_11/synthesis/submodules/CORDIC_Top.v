// Now the total width of fixed point is 11 bits, with the first bit as sign bit
// two integer bits, and 8 fractional bits
// 2's complement is not used because the normal binary representation can be transfered 
// to floating point easier, this can also be changed if needed
module CORDIC_Top
(
	clk,
	clk_en,
	aclr,
	z_in_float,
	cos_out_float
);
parameter WORD = 32;
parameter WIDTH = 24;
parameter DOT = 21;

input clk;
input clk_en;
input aclr;
input signed [WORD-1:0] z_in_float;
output signed [WORD-1:0] cos_out_float;
wire signed [WIDTH-1:0] z_in;

Inside_COS float2fix
(
	.floating_in(z_in_float),
	.fix_out(z_in)
);


// The registers that store the constants in loop up table
// This should be the fastest way, but requires lots of resources if there
// are multiple CORDIC kernels, this can be replaced by some memory system later


reg signed [WIDTH-1:0] LUT_1  = 24'b000110010010000111111011;
reg signed [WIDTH-1:0] LUT_2  = 24'b000011101101011000110011;
reg signed [WIDTH-1:0] LUT_3  = 24'b000001111101011011011101;
reg signed [WIDTH-1:0] LUT_4  = 24'b000000111111101010110111;
reg signed [WIDTH-1:0] LUT_5  = 24'b000000011111111101010101;
reg signed [WIDTH-1:0] LUT_6  = 24'b000000001111111111101010;
reg signed [WIDTH-1:0] LUT_7  = 24'b000000000111111111111101;
reg signed [WIDTH-1:0] LUT_8  = 24'b000000000011111111111111;
reg signed [WIDTH-1:0] LUT_9  = 24'b000000000001111111111111;
reg signed [WIDTH-1:0] LUT_10 = 24'b000000000000111111111111;
reg signed [WIDTH-1:0] LUT_11 = 24'b000000000000011111111111;
reg signed [WIDTH-1:0] LUT_12 = 24'b000000000000001111111111;
reg signed [WIDTH-1:0] LUT_13 = 24'b000000000000000111111111;
reg signed [WIDTH-1:0] LUT_14 = 24'b000000000000000011111111;
reg signed [WIDTH-1:0] LUT_15 = 24'b000000000000000001111111;
reg signed [WIDTH-1:0] LUT_16 = 24'b000000000000000000111111;
reg signed [WIDTH-1:0] LUT_17 = 24'b000000000000000000011111;
reg signed [WIDTH-1:0] LUT_18 = 24'b000000000000000000001111;		
reg signed [WIDTH-1:0] LUT_19 = 24'b000000000000000000000111;
reg signed [WIDTH-1:0] LUT_20 = 24'b000000000000000000000011;
reg signed [WIDTH-1:0] LUT_21 = 24'b000000000000000000000001;
				 
reg signed [WIDTH-1:0] X_INITIAL = 24'b000100110110111010011101;

reg signed [WIDTH-1:0] Y_INITIAL = 0;
//reg [WIDTH-1:0] z_in;

// The medium x, y, z
wire signed [WIDTH-1:0] x_1;
wire signed [WIDTH-1:0] y_1;
wire signed [WIDTH-1:0] z_1;

wire signed [WIDTH-1:0] x_2;
wire signed [WIDTH-1:0] y_2;
wire signed [WIDTH-1:0] z_2;

wire signed [WIDTH-1:0] x_3;
wire signed [WIDTH-1:0] y_3;
wire signed [WIDTH-1:0] z_3;

wire signed [WIDTH-1:0] x_4;
wire signed [WIDTH-1:0] y_4;
wire signed [WIDTH-1:0] z_4;

wire signed [WIDTH-1:0] x_5;
wire signed [WIDTH-1:0] y_5;
wire signed [WIDTH-1:0] z_5;

wire signed [WIDTH-1:0] x_6;
wire signed [WIDTH-1:0] y_6;
wire signed [WIDTH-1:0] z_6;

wire signed [WIDTH-1:0] x_7;
wire signed [WIDTH-1:0] y_7;
wire signed [WIDTH-1:0] z_7;

wire signed [WIDTH-1:0] x_8;
wire signed [WIDTH-1:0] y_8;
wire signed [WIDTH-1:0] z_8;

wire signed [WIDTH-1:0] x_9;
wire signed [WIDTH-1:0] y_9;
wire signed [WIDTH-1:0] z_9;

wire signed [WIDTH-1:0] x_10;
wire signed [WIDTH-1:0] y_10;
wire signed [WIDTH-1:0] z_10;

wire signed [WIDTH-1:0] x_11;
wire signed [WIDTH-1:0] y_11;
wire signed [WIDTH-1:0] z_11;

wire signed [WIDTH-1:0] x_12;
wire signed [WIDTH-1:0] y_12;
wire signed [WIDTH-1:0] z_12;

wire signed [WIDTH-1:0] x_13;
wire signed [WIDTH-1:0] y_13;
wire signed [WIDTH-1:0] z_13;

wire signed [WIDTH-1:0] x_14;
wire signed [WIDTH-1:0] y_14;
wire signed [WIDTH-1:0] z_14;

wire signed [WIDTH-1:0] x_15;
wire signed [WIDTH-1:0] y_15;
wire signed [WIDTH-1:0] z_15;

wire signed [WIDTH-1:0] x_16;
wire signed [WIDTH-1:0] y_16;
wire signed [WIDTH-1:0] z_16;

wire signed [WIDTH-1:0] x_17;
wire signed [WIDTH-1:0] y_17;
wire signed [WIDTH-1:0] z_17;

wire signed [WIDTH-1:0] x_18;
wire signed [WIDTH-1:0] y_18;
wire signed [WIDTH-1:0] z_18;

wire signed [WIDTH-1:0] x_19;
wire signed [WIDTH-1:0] y_19;
wire signed [WIDTH-1:0] z_19;

wire signed [WIDTH-1:0] x_20;
wire signed [WIDTH-1:0] y_20;
wire signed [WIDTH-1:0] z_20;

wire signed [WIDTH-1:0] cos_out;
wire signed [WIDTH-1:0] sin_out;
wire signed [WIDTH-1:0] z_21;


CORDIC_BASIC CORDIC_BASE_1 
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (X_INITIAL),
		.y_in (Y_INITIAL),
		.z_in (z_in),
		.LUT  (LUT_1),
		.I(5'd0),
		.x_out(x_1),
		.y_out(y_1),
		.z_out(z_1)
	);

CORDIC_BASIC CORDIC_BASE_2 
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_1),
		.y_in (y_1),
		.z_in (z_1),
		.LUT  (LUT_2),
		.I(5'd1),
		.x_out(x_2),
		.y_out(y_2),
		.z_out(z_2)
	);

CORDIC_BASIC CORDIC_BASE_3 
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_2),
		.y_in (y_2),
		.z_in (z_2),
		.LUT  (LUT_3),
		.I(5'd2),
		.x_out(x_3),
		.y_out(y_3),
		.z_out(z_3)
	);

CORDIC_BASIC CORDIC_BASE_4 
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_3),
		.y_in (y_3),
		.z_in (z_3),
		.LUT  (LUT_4),
		.I(5'd3),
		.x_out(x_4),
		.y_out(y_4),
		.z_out(z_4)
	);

CORDIC_BASIC CORDIC_BASE_5 
	(	
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_4),
		.y_in (y_4),
		.z_in (z_4),
		.LUT  (LUT_5),
		.I(5'd4),
		.x_out(x_5),
		.y_out(y_5),
		.z_out(z_5)
	);

CORDIC_BASIC CORDIC_BASE_6 
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_5),
		.y_in (y_5),
		.z_in (z_5),
		.LUT  (LUT_6),
		.I(5'd5),
		.x_out(x_6),
		.y_out(y_6),
		.z_out(z_6)
	);

CORDIC_BASIC CORDIC_BASE_7
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_6),
		.y_in (y_6),
		.z_in (z_6),
		.LUT  (LUT_7),
		.I(5'd6),
		.x_out(x_7),
		.y_out(y_7),
		.z_out(z_7)
	);

CORDIC_BASIC CORDIC_BASE_8
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_7),
		.y_in (y_7),
		.z_in (z_7),
		.LUT  (LUT_8),
		.I(5'd7),
		.x_out(x_8),
		.y_out(y_8),
		.z_out(z_8)
	);

CORDIC_BASIC CORDIC_BASE_9
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_8),
		.y_in (y_8),
		.z_in (z_8),
		.LUT  (LUT_9),
		.I(5'd8),
		.x_out(x_9),
		.y_out(y_9),
		.z_out(z_9)
	);
	
CORDIC_BASIC CORDIC_BASE_10
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_9),
		.y_in (y_9),
		.z_in (z_9),
		.LUT  (LUT_10),
		.I(5'd9),
		.x_out(x_10),
		.y_out(y_10),
		.z_out(z_10)
	);
	
CORDIC_BASIC CORDIC_BASE_11
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_10),
		.y_in (y_10),
		.z_in (z_10),
		.LUT  (LUT_11),
		.I(5'd10),
		.x_out(x_11),
		.y_out(y_11),
		.z_out(z_11)
	);

CORDIC_BASIC CORDIC_BASE_12 
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_11),
		.y_in (y_11),
		.z_in (z_11),
		.LUT  (LUT_12),
		.I(5'd11),
		.x_out(x_12),
		.y_out(y_12),
		.z_out(z_12)
	);
	
CORDIC_BASIC CORDIC_BASE_13
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_12),
		.y_in (y_12),
		.z_in (z_12),
		.LUT  (LUT_13),
		.I(5'd12),
		.x_out(x_13),
		.y_out(y_13),
		.z_out(z_13)
	);
	
CORDIC_BASIC CORDIC_BASE_14
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_13),
		.y_in (y_13),
		.z_in (z_13),
		.LUT  (LUT_14),
		.I(5'd13),
		.x_out(x_14),
		.y_out(y_14),
		.z_out(z_14)
	);
	
CORDIC_BASIC CORDIC_BASE_15
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_14),
		.y_in (y_14),
		.z_in (z_14),
		.LUT  (LUT_15),
		.I(5'd14),
		.x_out(x_15),
		.y_out(y_15),
		.z_out(z_15)
	);
	
CORDIC_BASIC CORDIC_BASE_16
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_15),
		.y_in (y_15),
		.z_in (z_15),
		.LUT  (LUT_16),
		.I(5'd15),
		.x_out(x_16),
		.y_out(y_16),
		.z_out(z_16)
	);
	
CORDIC_BASIC CORDIC_BASE_17
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_16),
		.y_in (y_16),
		.z_in (z_16),
		.LUT  (LUT_17),
		.I(5'd16),
		.x_out(x_17),
		.y_out(y_17),
		.z_out(z_17)
	);
	
CORDIC_BASIC CORDIC_BASE_18
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_17),
		.y_in (y_17),
		.z_in (z_17),
		.LUT  (LUT_18),
		.I(5'd17),
		.x_out(x_18),
		.y_out(y_18),
		.z_out(z_18)
	);
	
CORDIC_BASIC CORDIC_BASE_19
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_18),
		.y_in (y_18),
		.z_in (z_18),
		.LUT  (LUT_19),
		.I(5'd18),
		.x_out(x_19),
		.y_out(y_19),
		.z_out(z_19)
	);
	
CORDIC_BASIC CORDIC_BASE_20
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_19),
		.y_in (y_19),
		.z_in (z_19),
		.LUT  (LUT_20),
		.I(5'd19),
		.x_out(x_20),
		.y_out(y_20),
		.z_out(z_20)
	);
	
CORDIC_BASIC CORDIC_BASE_21
	(
		.clk(clk),
		.clk_en(clk_en),
		.aclr(aclr),
		.x_in (x_20),
		.y_in (y_20),
		.z_in (z_20),
		.LUT  (LUT_21),
		.I(5'd20),
		.x_out(cos_out),
		.y_out(sin_out),
		.z_out(z_21)
	);
	
Fix2Floating fix2float
(
	.fix_in(cos_out),
	.float_out(cos_out_float)
);
endmodule 