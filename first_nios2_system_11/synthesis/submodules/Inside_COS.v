module Inside_COS
(
	floating_in,
	fix_out
);

input signed [31:0] floating_in;
output signed [23:0] fix_out;
reg [23:0] fix_out = 0;

wire [31:0] floating_in_to_fix;
wire [23:0] fix_out_from_transfer;
reg [21:0] middle_subtraction = 0;

assign floating_in_to_fix[31] = floating_in[31];
assign floating_in_to_fix[30:23] = floating_in[30:23] - 8'd7;
assign floating_in_to_fix[22:0] = floating_in[22:0];


Floating2Fix Transfer1
(
	.floating_in(floating_in_to_fix),
	.fix_out(fix_out_from_transfer)
);

always @(*)
begin
	if(fix_out_from_transfer[21] == 1'b1)
	begin
		fix_out = {fix_out_from_transfer[23:22], 1'b0, fix_out_from_transfer[20:0]};
	end
	else if(fix_out_from_transfer[22] == 1'b1)
	begin
		fix_out = {fix_out_from_transfer[23], 2'b01, fix_out_from_transfer[20:0]};
	end
	else
	begin
		middle_subtraction = 22'b1000000000000000000000 - fix_out_from_transfer[21:0];
		fix_out = {2'b00, middle_subtraction[21:0]};
	end
end

endmodule
