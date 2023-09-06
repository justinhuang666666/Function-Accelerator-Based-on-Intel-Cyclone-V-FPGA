module Floating2Fix
(
	floating_in,
	fix_out
);

parameter WIDTH = 24;
parameter POINT = 21;
parameter INTEGER = 2;

input [31:0] floating_in;
output [WIDTH-1:0] fix_out;
reg [WIDTH-1:0] fix_out;
//reg [7:0] EXP;

always @(*)
begin
	case(floating_in[30:23])
		8'd128: begin
						fix_out[WIDTH-2:POINT] = {1'b1, floating_in[22]};
						fix_out[POINT-1:0] = floating_in[21:1];
						fix_out[WIDTH-1] = 0;
				  end
		8'd127: begin 
						fix_out[WIDTH-2:POINT] = 2'b01; 
						fix_out[POINT-1:0] = floating_in[22:(22 - POINT + 1)];
						fix_out[WIDTH-1] = 0;
				  end
		8'd126: begin 
						//EXP = 1;
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:0] = {1'b1, floating_in[22:(22-POINT + 2)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd125: begin 
						//EXP = 2; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(2 - 1) + 1)] = 0;
						fix_out[POINT-1-(2 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(2 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd124: begin 
						//parameter EXP1 = 3;  
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(3 - 1) + 1)] = 0;
						fix_out[POINT-1-(3 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(3 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd123: begin 
						//parameter EXP2 = 4;  
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(4 - 1) + 1)] = 0;
						fix_out[POINT-1-(4 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(4 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd122: begin 
						//parameter EXP3 = 5;  
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(5 - 1) + 1)] = 0;
						fix_out[POINT-1-(5 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(5 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd121: begin 
						//parameter EXP4 = 6;  
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(6 - 1) + 1)] = 0;
						fix_out[POINT-1-(6 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(6 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd120: begin 
						//parameter EXP5 = 7;  
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(7 - 1) + 1)] = 0;
						fix_out[POINT-1-(7 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(7 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd119: begin 
						//parameter EXP6 = 8;  
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(8 - 1) + 1)] = 0;
						fix_out[POINT-1-(8 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(8 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd118: begin 
						//parameter EXP7 = 9;  
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(9 - 1) + 1)] = 0;
						fix_out[POINT-1-(9 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(9 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd117: begin 
						//parameter EXP8 = 10;
					   fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(10 - 1) + 1)] = 0;
						fix_out[POINT-1-(10 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(10 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd116: begin 
						//parameter EXP9 = 11; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(11 - 1) + 1)] = 0;
						fix_out[POINT-1-(11 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(11 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd115: begin 
						//parameter EXP10 = 12; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(12 - 1) + 1)] = 0;
						fix_out[POINT-1-(12 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(12 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd114: begin 
						//EXP = 13; 
						/*fix_out[WIDTH-2:POINT] = 0;
						fix_out[POINT-1:0] = 1;
						fix_out[WIDTH-1] = 0;*/
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(13 - 1) + 1)] = 0;
						fix_out[POINT-1-(13 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(13 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd113: begin 
				      //EXP = 14;
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(14 - 1) + 1)] = 0;
						fix_out[POINT-1-(14 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(14 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd112: begin 
						//EXP = 15; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(15 - 1) + 1)] = 0;
						fix_out[POINT-1-(15 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(15 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd111: begin 
						//EXP = 16; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(16 - 1) + 1)] = 0;
						fix_out[POINT-1-(16 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(16 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd110: begin 
						//EXP = 17; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(17 - 1) + 1)] = 0;
						fix_out[POINT-1-(17 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(17 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd109: begin 
						//EXP = 18; 
						/*fix_out[WIDTH-2:POINT] = 0;
						fix_out[POINT-1:0] = 1;
						fix_out[WIDTH-1] = 0;*/
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(18 - 1) + 1)] = 0;
						fix_out[POINT-1-(18 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(18 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd108: begin 
						//EXP = 19; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(19 - 1) + 1)] = 0;
						fix_out[POINT-1-(19 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(19 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd107: begin 
						//EXP = 20; 
						fix_out[WIDTH-2:POINT] = 2'd0;
						fix_out[POINT-1:(POINT-1-(20 - 1) + 1)] = 0;
						fix_out[POINT-1-(20 - 1):0] = {1'b1, floating_in[22:(22 - (POINT-1-(20 - 1)) + 1)]};
						fix_out[WIDTH-1] = 0;
				  end
		8'd106: begin 
						//EXP = 21; 
						fix_out[WIDTH-2:POINT] = 0;
						fix_out[POINT-1:0] = 1;
						fix_out[WIDTH-1] = 0;
				  end
		/*8'd105: begin EXP = 22; end
		8'd104: begin EXP = 23; end
		8'd103: begin EXP = 24; end
		8'd102: begin EXP = 25; end
		8'd101: begin EXP = 26; end
		8'd100: begin EXP = 27; end
		8'd99 : begin EXP = 28; end
		8'd98 : begin EXP = 29; end
		8'd97 : begin EXP = 30; end
		8'd96 : begin EXP = 31; end
		8'd95 : begin EXP = 32; end*/
		default: begin
						fix_out = 0;
					end
	endcase	
end


/*always @(*)
begin
	if (floating_in[30:23] > 128)
	begin
		EXP <= floating_in[30:23] - 127;
		// Integer part
		fix_out[WIDTH-2:POINT] <= floating_in[(22 - (EXP) + 2):(22 - (EXP) + 1)];
		// fractional part
		fix_out[POINT-1:0] <= floating_in[(22 - (EXP)) : (22 - (EXP) - POINT + 1)];
		// Sign part
		fix_out[WIDTH-1] <= 0;
	end
	else if(floating_in[30:23] == 128)
	begin
		EXP <= floating_in[30:23] - 127;
		// Integer part
		fix_out[WIDTH-2:POINT] <= {1, floating_in[22]};
		// fractional part
		fix_out[POINT-1:0] <= floating_in[(22 - (EXP)) : (22 - (EXP) - POINT + 1)];
		// Sign part
		fix_out[WIDTH-1] <= 0;
	end
	if(floating_in[30:23] == 8'd127)
	begin
		// Integer part
		fix_out[WIDTH-2:POINT] <= 1;
		// fractional part
		fix_out[POINT-1:0] <= floating_in[22:(22 - POINT + 1)];
		// Sign part
		fix_out[WIDTH-1] <= 0;
	end
	else if(floating_in[30:23] == 8'd126)
	begin
		// Integer part
		fix_out[WIDTH-2:POINT] <= 0;
		// fractional part
		fix_out[POINT-1:0] <= {1, floating_in[22:(22-POINT + 2)]};	
		// Sign part
		fix_out[WIDTH-1] <= 0;
	end
	else if(floating_in[30:23] > 8'd114)
	begin
		// Integer part
		fix_out[WIDTH-2:POINT] <= 0;
		// fractional part
		fix_out[POINT-1:(POINT-1-(EXP - 1) + 1)] <= 0;
		fix_out[POINT-1-(EXP - 1):0] <= {1, floating_in[22:(22 - (POINT-1-(EXP - 1)) + 1)]};
		// Sign part
		fix_out[WIDTH-1] <= 0;
	end
	else if(floating_in[30:23] == 8'd114)
	begin 
		// Integer part
		fix_out[WIDTH-2:POINT] <= 0;
		// fractional part
		fix_out[POINT-1:0] <= 1;
		// Sign part
		fix_out[WIDTH-1] <= 0;
	end
	else
	begin
		fix_out <= 0;
	end
end*/

endmodule

