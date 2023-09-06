module DOT_PRODUCT
(
	clk,
	clk_en,
	aclr,
	x_in,
	tick,
	dot_out,
);

input clk;
input aclr;
input clk_en;
input tick;
input signed [31:0] x_in;
output signed [31:0] dot_out;
/*output signed [31:0] check1;
output signed [31:0] check2;
output signed [31:0] check3;*/
//output signed [31:0] mult_pip_15;
//output signed [31:0] cos_out;

wire signed [31:0] mult_out;
wire signed [31:0] mult_out_mid;
wire signed [31:0] second_mult_out;
wire signed [31:0] second_mult_out_mid;
reg signed [31:0] mult_pip_1 = 0;
reg signed [31:0] mult_pip_2 = 0;
reg signed [31:0] mult_pip_3 = 0;
reg signed [31:0] mult_pip_4 = 0;
reg signed [31:0] mult_pip_5 = 0;
reg signed [31:0] mult_pip_6 = 0;
reg signed [31:0] mult_pip_7 = 0;
reg signed [31:0] mult_pip_8 = 0;
reg signed [31:0] mult_pip_9 = 0;
reg signed [31:0] mult_pip_10 = 0;
reg signed [31:0] mult_pip_11 = 0;
reg signed [31:0] mult_pip_12 = 0;
reg signed [31:0] mult_pip_13 = 0;
reg signed [31:0] mult_pip_14 = 0;
reg signed [31:0] mult_pip_15 = 0;
reg signed [31:0] mult_pip_16 = 0;
wire signed [31:0] sin_out;
wire signed [31:0] angle_out;
wire signed [31:0] cos_out;
reg signed [31:0] zero_point5_out = 0;
reg signed [31:0] zero_point5_1 = 0;
reg signed [31:0] zero_point5_2 = 0;
reg signed [31:0] zero_point5_3 = 0;
reg signed [31:0] zero_point5_4 = 0;
reg signed [31:0] zero_point5_5 = 0;
reg signed [31:0] zero_point5_6 = 0;
reg signed [31:0] zero_point5_7 = 0;
reg signed [31:0] zero_point5_8 = 0;
reg signed [31:0] zero_point5_9 = 0;
reg signed [31:0] zero_point5_10 = 0;
reg signed [31:0] zero_point5_11 = 0;
reg signed [31:0] zero_point5_12 = 0;
reg signed [31:0] zero_point5_13 = 0;
reg signed [31:0] zero_point5_14 = 0;
reg signed [31:0] zero_point5_15 = 0;
reg signed [31:0] zero_point5_16 = 0;
wire signed [31:0] zero_point_5_x;


reg signed[31:0] mid_1 = 0;
reg signed[31:0] mid_2 = 0;
reg signed[31:0] mid_3 = 0;
reg signed[31:0] mid_4 = 0;
reg signed[31:0] mid_5 = 0;

reg signed[31:0] mid_1_2 = 0;
reg signed[31:0] mid_2_2 = 0;
reg signed[31:0] mid_3_2 = 0;
reg signed[31:0] mid_4_2 = 0;
reg signed[31:0] mid_5_2 = 0;


// First calculate the 0.5x
assign zero_point_5_x = (x_in == 32'b0) ? 32'b0 : {x_in[31], x_in[30:23]-8'b1, x_in[22:0]};

//assign check3 = zero_point_5_x;

/*shift_register_6 shift
(
	.x_in(zero_point_5_X),
	.clk(clk),
	.clk_en(clk_en),
	.aclr(aclr),
	.result(zero_point5_out)
);*/

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_1 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_1 <= zero_point_5_x;
		end
		else
		begin
			mid_1 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_2<= mid_1;
		end
		else
		begin
			mid_2 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_3 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_3 <= mid_2;
		end
		else
		begin
			mid_3 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_4 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_4<= mid_3;
		end
		else
		begin
			mid_4 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_5 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_5 <= mid_4;
		end
		else
		begin
			mid_5 <= 0;
		end
	end
end


always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		zero_point5_out <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			zero_point5_out <= mid_5;
		end
		else
		begin
			zero_point5_out <= 0;
		end
	end
end

// 6 cycles delay

MOD_FP_MULT MULT1
(
	.dataa(x_in),
	.datab(x_in),
	.clk_en(clk_en),
	.clock(clk),
	.aclr(aclr),
	.result(mult_out)
);

assign mult_out_mid = (tick == 1) ? 0 : mult_out;

CORDIC_Top CORDIC
(
	.clk(clk),
	.clk_en(clk_en),
	.aclr(aclr),
	.z_in_float(x_in),
	.cos_out_float(cos_out)
);


// 16 shift registers to match cycles
always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_1 <= 0;
		zero_point5_1 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_1 <= mult_out_mid;
			zero_point5_1 <= zero_point5_out;
		end
		else
		begin
			mult_pip_1 <= 0;
			zero_point5_1 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_2 <= 0;
		zero_point5_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_2 <= mult_pip_1;
			zero_point5_2 <= zero_point5_1;
		end
		else
		begin
			mult_pip_2 <= 0;
			zero_point5_2 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_3 <= 0;
		zero_point5_3 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_3 <= mult_pip_2;
			zero_point5_3 <= zero_point5_2;
		end
		else
		begin
			mult_pip_3 <= 0;
			zero_point5_3 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_4 <= 0;
		zero_point5_4 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_4 <= mult_pip_3;
			zero_point5_4 <= zero_point5_3;
		end
		else
		begin
			mult_pip_4 <= 0;
			zero_point5_4 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_5 <= 0;
		zero_point5_5 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin 
			mult_pip_5 <= mult_pip_4;
			zero_point5_5 <= zero_point5_4;
		end
		else
		begin
			mult_pip_5 <= 0;
			zero_point5_5 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_6 <= 0;
		zero_point5_6 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_6 <= mult_pip_5;
			zero_point5_6 <= zero_point5_5;
		end
		else
		begin
			mult_pip_6 <= 0;
			zero_point5_6 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_7 <= 0;
		zero_point5_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_7 <= mult_pip_6;
			zero_point5_7 <= zero_point5_6;
		end
		else
		begin
			mult_pip_7 <= 0;
			zero_point5_7 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_8 <= 0;
		zero_point5_8 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_8 <= mult_pip_7;
			zero_point5_8 <= zero_point5_7;
		end
		else
		begin
			mult_pip_8 <= 0;
			zero_point5_8 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_9 <= 0;
		zero_point5_9 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_9 <= mult_pip_8;
			zero_point5_9 <= zero_point5_8;
		end
		else
		begin
			mult_pip_9 <= 0;
			zero_point5_9 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_10 <= 0;
		zero_point5_10 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_10 <= mult_pip_9;
			zero_point5_10 <= zero_point5_9;
		end
		else
		begin
			mult_pip_10 <= 0;
			zero_point5_10 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_11 <= 0;
		zero_point5_11 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_11 <= mult_pip_10;
			zero_point5_11 <= zero_point5_10;
		end
		else
		begin
			mult_pip_11 <= 0;
			zero_point5_11 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_12 <= 0;
		zero_point5_12 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_12 <= mult_pip_11;
			zero_point5_12 <= zero_point5_11;
		end
		else
		begin
			mult_pip_12 <= 0;
			zero_point5_12 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_13 <= 0;
		zero_point5_13 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_13 <= mult_pip_12;
			zero_point5_13 <= zero_point5_12;
		end
		else
		begin
			mult_pip_13 <= 0;
			zero_point5_13 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_14 <= 0;
		zero_point5_14 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_14 <= mult_pip_13;
			zero_point5_14 <= zero_point5_13;
		end
		else
		begin
			mult_pip_14 <= 0;
			zero_point5_14 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mult_pip_15 <= 0;
		zero_point5_15 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mult_pip_15 <= mult_pip_14;
			zero_point5_15 <= zero_point5_14;
		end
		else
		begin
			mult_pip_15 <= 0;
			zero_point5_15 <= 0;
		end
	end
end

assign check1 = mult_pip_15;
assign check2 = zero_point5_15;

MOD_FP_MULT MULT2
(
	.dataa(mult_pip_15),
	.datab(cos_out),
	.clk_en(clk_en),
	.clock(clk),
	.aclr(aclr),
	.result(second_mult_out)
);
assign second_mult_out_mid = (tick == 1) ? 0 : second_mult_out;


always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_1_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_1_2 <= zero_point5_15;
		end
		else
		begin
			mid_1_2 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_2_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_2_2<= mid_1_2;
		end
		else
		begin
			mid_2_2 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_3_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_3_2 <= mid_2_2;
		end
		else
		begin
			mid_3_2 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_4_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_4_2<= mid_3_2;
		end
		else
		begin
			mid_4_2 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_5_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_5_2 <= mid_4_2;
		end
		else
		begin
			mid_5_2 <= 0;
		end
	end
end


always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		zero_point5_16 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			zero_point5_16 <= mid_5_2;
		end
		else
		begin
			zero_point5_16 <= 0;
		end
	end
end


MOD_FP_ADD	ADD (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( zero_point5_16 ),
	.datab ( second_mult_out_mid ),
	.result ( dot_out )
	);
//assign check1 = zero_point5_16;
//assign check2 = second_mult_out;



endmodule



