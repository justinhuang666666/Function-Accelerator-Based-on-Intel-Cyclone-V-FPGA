module Fix2Floating
(
	fix_in,
	float_out
);

input [23:0] fix_in;
output [31:0] float_out;
reg [31:0] float_out;


// The regs for using method two
/*reg Divide_Conquer_start;
reg [30:0] first_five;
reg [30:0] last_sixteen;
reg [3:0] point_position = 4'b0;
reg [7:0] first_level;
reg [3:0] second_level;
reg [1:0] third_level;*/

// first transfer from two's complement into normal form
// Because in our case, the output of CORDIC is always positive due to the range of the input
// so no need to considering about the transformation of two's complement



// Then find the first 1 appearing in fractional part

// The first method

always @(*)
begin
	if(fix_in[22:21] == 2'b1)
	begin
		float_out[31:0] = 32'b00111111100000000000000000000000;
	end
	else if(fix_in[20] == 1'b1)
	begin
		float_out[31:0] = {1'b0, 8'b01111110, fix_in[19:0], 3'b0};
	end
	else if(fix_in[19] == 1'b1)
	begin
		float_out[31:0] = {1'b0, 8'b01111101, fix_in[18:0], 4'b0};
	end
	else if(fix_in[18] == 1'b1)
	begin
		float_out[31:0] = {1'b0, 8'b01111100, fix_in[17:0], 5'b0};
	end
	else if(fix_in[17] == 1'b1)
	begin
		float_out[31:0] = {1'b0, 8'b01111011, fix_in[16:0], 6'b0};
	end
	else if(fix_in[16] == 1'b1)
	begin
		float_out[31:0] = {1'b0, 8'b01111010, fix_in[15:0], 7'b0};
	end
	else if(fix_in[15] == 1'b1)
	begin
		float_out[31:0] = {1'b0, 8'b01111001, fix_in[14:0], 8'b0};
	end
	else if(fix_in[14] == 1'b1)
	begin
		float_out[31:0] = {1'b0, 8'b01111000, fix_in[13:0], 9'b0};
	end
	else if(fix_in[13] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110111, fix_in[12:0], 10'b0};
	end
	else if(fix_in[12] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110110, fix_in[11:0], 11'b0};
	end
	else if(fix_in[11] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110101, fix_in[10:0], 12'b0};
	end
	else if(fix_in[10] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110100, fix_in[9:0], 13'b0};
	end
	else if(fix_in[9] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110011, fix_in[8:0], 14'b0};
	end
	else if(fix_in[8] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110010, fix_in[7:0], 15'b0};
	end
	else if(fix_in[7] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110001, fix_in[6:0], 16'b0};
	end
	else if(fix_in[6] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01110000, fix_in[5:0], 17'b0};
	end
	else if(fix_in[5] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01101111, fix_in[4:0], 18'b0};
	end
	else if(fix_in[4] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01101110, fix_in[3:0], 19'b0};
	end
	else if(fix_in[3] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01101101, fix_in[2:0], 20'b0};
	end
	else if(fix_in[2] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01101100, fix_in[1:0], 21'b0};
	end
	else if(fix_in[1] == 1'b1)
	begin
	   float_out[31:0] = {1'b0, 8'b01101011, fix_in[0], 22'b0};
	end
	else
	begin
		float_out[31:0] = {1'b0, 8'b01101010, 23'b0};
	end
end



// The secod method used is to first using the basic mux method to determine whether the first 
// 5 bits containing the first one, otherwise, using divide and conquer for the remaining 16 bits 
// to find the position of the first one, otherwise the fan in and fan out would be quite high, besides,
// I think such kind of structure is good for pipelining and requires less cycle than the normal method


/*always @(*)
begin
	if(fix_in[22:21] = 2'b1)
	begin
		Divide_Conquer_start = 0;
		first_five[30:0] = 31'b0111111100000000000000000000000;
	end
	else if(fix_in[20] == 1'b1)
	begin
		Divide_Conquer_start = 0;
		first_five[30:0] = {8'b01111110, fix_in[19:0], 3'b0};
	end
	else if(fix_in[19] == 1'b1)
	begin
		Divide_Conquer_start = 0;
		first_five[30:0] = {8'b01111101, fix_in[18:0], 4'b0};
	end
	else if(fix_in[18] == 1'b1)
	begin
		Divide_Conquer_start = 0;
		first_five[30:0] = {8'b01111100, fix_in[17:0], 5'b0};
	end
	else if(fix_in[17] == 1'b1)
	begin
		Divide_Conquer_start = 0;
		first_five[30:0] = {8'b01111011, fix_in[16:0], 6'b0};
	end
	else if(fix_in[16] == 1'b1)
	begin
		Divide_Conquer_start = 0;
		first_five[30:0] = {8'b01111010, fix_in[15:0], 7'b0};
	end
	else
	begin
		Divide_Conquer_start = 1'b1;
	end
end

// Starting the divide and conquer
always @(*)
begin
	if(fix_in[15:8] == 0)
	begin 
		point_position[3] = 1'b0;
		first_level = fix_in[7:0];
	end
	else
	begin
		point_position[3] = 1'b1;
		first_level = fix_in[15:8];
	end
end

always @(*)
begin
	if(first_level[7:4] == 0)
	begin
		point_position[2] = 1'b0;
		second_level = first_level[3:0];
	end
	else
	begin
		point_position[2] = 1'b1;
		second_level = first_level[7:4];
	end
end

always @(*)
begin
	if(second_level[3:2] == 0)
	begin
		point_position[1] = 1'b0;
		third_level = second_level[1:0];
	end
	else
	begin
		point_position[1] = 1'b1;
		third_level = second_level[3:2];
	end
end

always @(*)
begin
	if(third_level[1] == 0)
	begin
		point_position[0] = 1'b0;
	end
	else
	begin
		point_position[0] = 1'b1;
	end
end

// following a decoder to find the actual out
always @(*)
begin
	case(point_position)
		4'd15: begin
					last_sixteen = {8'b01111001, fix_in[14:0], 8'b0};
			    end
		4'd14: begin
					last_sixteen = {8'b01111000, fix_in[13:0], 9'b0};
				 end
	   4'd13: begin
					last_sixteen = {8'b01110111, fix_in[12:0], 10'b0};
		       end
	   4'd12: begin
					last_sixteen = {8'b01110110, fix_in[11:0], 11'b0};
		       end
		4'd11: begin
					last_sixteen = {8'b01110101, fix_in[10:0], 12'b0};
		       end
		4'd10: begin
					last_sixteen = {8'b01110100, fix_in[9:0],  13'b0};
		       end
	   4'd9:  begin
					last_sixteen = {8'b01110011, fix_in[8:0],  14'b0};
		       end
	   4'd8:  begin
					last_sixteen = {8'b01110010, fix_in[7:0],  15'b0};
		       end
		4'd7:  begin
					last_sixteen = {8'b01110001, fix_in[6:0],  16'b0};
		       end
		4'd6:  begin
					last_sixteen = {8'b01110000, fix_in[5:0],  17'b0};
		       end
		4'd5:  begin
					last_sixteen = {8'b01101111, fix_in[4:0],  18'b0};
		       end
		4'd4:  begin
					last_sixteen = {8'b01101110, fix_in[3:0],  19'b0};
		       end
		4'd3:  begin
					last_sixteen = {8'b01101101, fix_in[2:0],  20'b0};
		       end
		4'd2:  begin
					last_sixteen = {8'b01101100, fix_in[1:0],  21'b0};
		       end
		4'd1:  begin
					last_sixteen = {8'b01101011, fix_in[0],    22'b0};
		       end
		4'd0:  begin
					last_sixteen = {8'b01101010, 23'b0};
		       end
	
	endcase
end

assign float_out[30:0] = Divide_Conquer_start ? last_sixteen : first_five;
assign float_out[31] = 0;*/



endmodule
