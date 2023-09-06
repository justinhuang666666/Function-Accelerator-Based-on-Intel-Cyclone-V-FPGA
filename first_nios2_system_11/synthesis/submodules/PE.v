module PE
(
	clk,
	aclr,
	clk_en,
	x_in,
	y_in,
	tick,
	out
);

input clk;
input aclr;
input clk_en;
input tick;
input signed[31:0] x_in;
input signed[31:0] y_in;
output signed[31:0] out;
/*output signed[31:0] check1;
output signed[31:0] check2;
output signed[31:0] check3;
output signed[31:0] check4;
output signed[31:0] check5;
output signed[31:0] check6;
output signed[31:0] check7;
output signed[31:0] check8;*/

wire signed[31:0] Sum_of_DOT;
wire signed[31:0] Acc_out;
reg signed[31:0] Tree_in_1 = 0;
reg signed[31:0] Tree_in_2 = 0;
reg signed[31:0] Tree_in_3 = 0;
reg signed[31:0] Tree_in_4 = 0;
reg signed[31:0] Tree_in_5 = 0;
reg signed[31:0] Tree_in_6 = 0;
reg signed[31:0] Tree_in_7 = 0;
wire signed[31:0] Tree_second_1;
wire signed[31:0] Tree_second_2;
wire signed[31:0] Tree_second_3;
wire signed[31:0] Tree_second_4;
wire signed[31:0] Tree_third_1;
wire signed[31:0] Tree_third_2;


// Define the registers needed for shift register 7
reg signed[31:0] mid_1_7 = 0;
reg signed[31:0] mid_2_7 = 0;
reg signed[31:0] mid_3_7 = 0;
reg signed[31:0] mid_4_7 = 0;
reg signed[31:0] mid_5_7 = 0;
reg signed[31:0] mid_6_7 = 0;
// Define the registers needed for shift register 6
reg signed[31:0] mid_1_6 = 0;
reg signed[31:0] mid_2_6 = 0;
reg signed[31:0] mid_3_6 = 0;
reg signed[31:0] mid_4_6 = 0;
reg signed[31:0] mid_5_6 = 0;
// Define the registers needed for shift register 5
reg signed[31:0] mid_1_5 = 0;
reg signed[31:0] mid_2_5 = 0;
reg signed[31:0] mid_3_5 = 0;
reg signed[31:0] mid_4_5 = 0;
// Define the registers needed for shift register 4
reg signed[31:0] mid_1_4 = 0;
reg signed[31:0] mid_2_4 = 0;
reg signed[31:0] mid_3_4 = 0;
// Define the registers needed for shift register 3
reg signed[31:0] mid_1_3 = 0;
reg signed[31:0] mid_2_3 = 0;
// Define the registers needed for shift register 2
reg signed[31:0] mid_1_2 = 0;
wire signed[31:0] dot1_out;
wire signed[31:0] dot2_out;
reg signed[31:0] dot1_out_mid = 0;
reg signed[31:0] dot2_out_mid = 0;
reg signed[31:0] Acc_out_mid = 0;


// First level is DOT product
DOT_PRODUCT DOT1
(
	.clk(clk),
	.clk_en(clk_en),
	.aclr(aclr),
	.x_in(x_in),
	.tick(tick),
	.dot_out(dot1_out)
);

DOT_PRODUCT DOT2
(
	.clk(clk),
	.clk_en(clk_en),
	.aclr(aclr),
	.x_in(y_in),
	.tick(tick),
	.dot_out(dot2_out)
);


/*assign check1 = dot1_out_mid;
assign check2 = dot2_out_mid;
assign check3 = Sum_of_DOT;
assign check4 = 0;
assign check5 = 0;
assign check6 = 0;
assign check7 = 0;
assign check8 = 0;*/

always @(*)
begin
	if(aclr == 1'b1)
	begin
		dot1_out_mid = 0;
		dot2_out_mid = 0;
	end
	else
	begin
		dot1_out_mid = dot1_out;
		dot2_out_mid = dot2_out;
	end
end
//
//
// Adder for adding the outputs of two DOTs
MOD_FP_ADD	SumDots (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( dot1_out_mid ),
	.datab ( dot2_out_mid ),
	.result ( Sum_of_DOT )
	);

// goes to the accumulator
MOD_FP_ADD	Accumulator1 (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Acc_out_mid ),
	.datab ( Sum_of_DOT ),
	.result ( Acc_out )
	);

always @(*)
begin
	if(aclr == 1'b1)
	begin
		Acc_out_mid = 0;
	end
	else
	begin
		Acc_out_mid = Acc_out;
	end
end


// The last stage to find the output based on tree structure
// First part is to delay 8 cycles

////////////// First shift 7 cycles /////////////

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_1_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_1_7 <= Acc_out;
		end
		else
		begin
			mid_1_7 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_2_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_2_7<= mid_1_7;
		end
		else
		begin
			mid_2_7 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_3_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_3_7 <= mid_2_7;
		end
		else
		begin
			mid_3_7 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_4_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_4_7<= mid_3_7;
		end
		else
		begin
			mid_4_7 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_5_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_5_7 <= mid_4_7;
		end
		else
		begin
			mid_5_7 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_6_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_6_7<= mid_5_7;
		end
		else
		begin
			mid_6_7 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		 Tree_in_7 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			Tree_in_7 <= mid_6_7;
		end
		else
		begin
			Tree_in_7 <= 0;
		end
	end
end

////////////////////////////////////////////////

/////////// Shift 6 cycles //////////////

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_1_6 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_1_6 <= Acc_out;
		end
		else
		begin
			mid_1_6 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_2_6 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_2_6<= mid_1_6;
		end
		else
		begin
			mid_2_6 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_3_6 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_3_6 <= mid_2_6;
		end
		else
		begin
			mid_3_6 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_4_6 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_4_6<= mid_3_6;
		end
		else
		begin
			mid_4_6 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_5_6 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_5_6 <= mid_4_6;
		end
		else
		begin
			mid_5_6 <= 0;
		end
	end
end


always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		Tree_in_6 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			Tree_in_6 <= mid_5_6;
		end
		else
		begin
			Tree_in_6 <= 0;
		end
	end
end

////////////////////////////////////////////

////////// Shift 5 cycles /////////////////

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_1_5 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_1_5 <= Acc_out;
		end
		else
		begin
			mid_1_5 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_2_5 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_2_5<= mid_1_5;
		end
		else
		begin
			mid_2_5 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_3_5 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_3_5 <= mid_2_5;
		end
		else
		begin
			mid_3_5 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_4_5 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_4_5<= mid_3_5;
		end
		else
		begin
			mid_4_5 <= 0;
		end
	end
end


always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		Tree_in_5 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			Tree_in_5 <= mid_4_5;
		end
		else
		begin
			Tree_in_5 <= 0;
		end
	end
end


///////////////////////////////////////////

//////////// Shift 4 cycles ////////////

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_1_4 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_1_4 <= Acc_out;
		end
		else
		begin
			mid_1_4 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_2_4 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_2_4<= mid_1_4;
		end
		else
		begin
			mid_2_4 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_3_4 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_3_4 <= mid_2_4;
		end
		else
		begin
			mid_3_4 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		Tree_in_4 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			Tree_in_4 <= mid_3_4;
		end
		else
		begin
			Tree_in_4 <= 0;
		end
	end
end
////////////////////////////////////////

/////////// Shift 3 cycles /////////////
always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_1_3 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_1_3 <= Acc_out;
		end
		else
		begin
			mid_1_3 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		mid_2_3 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			mid_2_3<= mid_1_3;
		end
		else
		begin
			mid_2_3 <= 0;
		end
	end
end

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		Tree_in_3 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			Tree_in_3 <= mid_2_3;
		end
		else
		begin
			Tree_in_3 <= 0;
		end
	end
end

/////////////////////////////////////////

//////// Shift 2 cycles /////////////////

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
			mid_1_2 <= Acc_out;
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
		Tree_in_2 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			Tree_in_2 <= mid_1_2;
		end
		else
		begin
			Tree_in_2 <= 0;
		end
	end
end

//////////////////////////////////////////

////////// Shift 1 cycle //////////////

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin 
		Tree_in_1 <= 0;
	end
	else
	begin
		if(clk_en == 1'b1)
		begin
			Tree_in_1 <= Acc_out;
		end
		else
		begin
			Tree_in_1 <= 0;
		end
	end
end

//////////////////////////////////////////

// For check
//assign check1 = Acc_out;
//assign check2 = Tree_in_1;
/*assign check3 = Tree_in_2;
assign check4 = Tree_in_3;
assign check5 = Tree_in_4;
assign check6 = Tree_in_5;
assign check7 = Tree_in_6;
assign check8 = Tree_in_7;*/

// Now get into the tree structured adders

// first level
MOD_FP_ADD	Level1_1 (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Tree_in_7 ),
	.datab ( Tree_in_6 ),
	.result ( Tree_second_1 )
	);

MOD_FP_ADD	Level1_2 (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Tree_in_5 ),
	.datab ( Tree_in_4 ),
	.result ( Tree_second_2 )
	);

MOD_FP_ADD	Level1_3 (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Tree_in_3 ),
	.datab ( Tree_in_2 ),
	.result ( Tree_second_3 )
	);

MOD_FP_ADD	Level1_4 (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Tree_in_1 ),
	.datab ( Acc_out ),
	.result ( Tree_second_4 )
	);
	
// second level

MOD_FP_ADD	Level2_1 (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Tree_second_1 ),
	.datab ( Tree_second_2 ),
	.result ( Tree_third_1 )
	);

MOD_FP_ADD	Level2_2 (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Tree_second_3 ),
	.datab ( Tree_second_4 ),
	.result ( Tree_third_2 )
	);

// Third level
MOD_FP_ADD	Level3_final (
	.aclr ( aclr ),
	.clk_en ( clk_en ),
	.clock ( clk),
	.dataa ( Tree_third_1 ),
	.datab ( Tree_third_2 ),
	.result ( out )
	);


endmodule 
