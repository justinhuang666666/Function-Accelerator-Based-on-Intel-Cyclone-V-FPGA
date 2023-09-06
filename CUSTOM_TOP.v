module CUSTOM_TOP
(
	input aclr,
	input clk_en,
	input clock,
	input [31:0] dataa,
	input [31:0] datab,
	input [7:0] N,
	output reg [31:0] result);
	
	wire [31:0] result_sub;
	wire [31:0] result_mult;

	MOD_FP_SUB	sub (
				.aclr (aclr),
				.clk_en (clk_en),
				.clock (clock),
				.dataa (dataa),
				.datab (datab),
				.result (result_sub));
	MOD_FP_MULT  mult(
				.aclr (aclr),
				.clk_en (clk_en),
				.clock (clock),
				.dataa (dataa),
				.datab (datab),
				.result (result_mult));
				
	always@(*) begin
	
		if(aclr) begin
		result <= 32'b0;
		end
		
		case(N) 
			8'b00000000: begin
				result <= result_sub;
			end
			8'b00000001: begin
				result <= result_mult;
			end
			default: begin
				result <= 8'b00000000;
			end
		endcase
	end


endmodule