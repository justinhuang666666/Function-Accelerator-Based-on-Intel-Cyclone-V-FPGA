module CORDIC_BASIC
(
	clk,
	clk_en,
	aclr,
	x_in,
	y_in,
	z_in,
	LUT,
	I,
	x_out,
	y_out,
	z_out
);

parameter BIT = 24;
parameter POINT = 21;

input  clk;
input  clk_en;
input  aclr;
input [4:0] I;
input signed [BIT-1:0]x_in;
input signed [BIT-1:0]y_in;
input signed [BIT-1:0]z_in;
input signed [BIT-1:0]LUT;
output signed [BIT-1:0]x_out;
reg signed [BIT-1:0]x_out = 0;
output signed [BIT-1:0]y_out;
reg signed [BIT-1:0]y_out = 0;
output signed [BIT-1:0]z_out;
reg signed [BIT-1:0]z_out = 0;

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1) begin
		x_out <= 0;
		y_out <= 0;
		z_out <= 0;
	end
	else begin
		if (clk_en == 1) begin
			//The following add and subtract can be replaced by self-defined adder or subtractor
			//now by using +, the default adder is simple ripple carry adder
			x_out <= z_in[BIT-1] ? (x_in + (y_in >>> I)) : (x_in - (y_in >>> I));
			y_out <= z_in[BIT-1] ? (y_in - (x_in >>> I)) : (y_in + (x_in >>> I));
			z_out <= z_in[BIT-1] ? (z_in + LUT) : (z_in - LUT);
		end
		else begin
			x_out <= 0;
			y_out <= 0;
			z_out <= 0;
		end
	end
end

endmodule
 
 

 






















