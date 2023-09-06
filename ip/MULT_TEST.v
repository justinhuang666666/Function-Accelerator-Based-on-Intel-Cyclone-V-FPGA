module MULT_TEST
(
	dataa,
	datab,
	clk_en,
	clock,
	aclr,
	result
);

input signed [31:0] dataa;
input signed [31:0] datab;
input clk_en;
input clock;
input aclr;
output signed [31:0] result;

MOD_FP_MULT MULT1
	(
	.dataa(dataa),
	.datab(datab),
	.clk_en(clk_en),
	.clock(clock),
	.aclr(aclr),
	.result(result)
	);
	
endmodule
