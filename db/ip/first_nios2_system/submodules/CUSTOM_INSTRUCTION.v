module CUSTOM_INSTRUCTION
(
	clk,
	clk_en,
	aclr,
	start,
	N,
	dataa,
	datab,
	done,
	result,
	//debug
//	STATE,
//	clk_en_use,
//	tick,
//	done,
//	COUNT,
//	COUNT_INIT,
// x_in,
//	y_in
);

input clk;
input clk_en;
input aclr;
input start;
input [7:0] N;
input [31:0] dataa;
input [31:0] datab;
output done;
output [31:0] result;

//debug
//output [1:0] STATE;
//output clk_en_use;
//output tick;
//output unsigned [6:0] COUNT = 7'b0;
//output unsigned [5:0] COUNT_INIT = 6'b0;
//output [31:0] x_in;
//output [31:0] y_in;

parameter IDLE = 2'b00;
parameter PROCESS = 2'b01;
parameter FINISH = 2'b10;
parameter CYCLE_DELAY = 7'd74;//36+8+8+8+8+8
parameter INIT_BOUND1 = 6'd2;
parameter INIT_BOUND2 = 6'd5;

reg [1:0] STATE;
reg clk_en_use;
reg tick;
reg done;
reg unsigned [6:0]COUNT = 7'b0;
reg unsigned [5:0]COUNT_INIT = 6'b0;
reg [31:0] x_in;
reg [31:0] y_in;

always @(posedge clk or posedge aclr)
begin
	if(aclr == 1'b1)
	begin
		STATE <= 0;
		clk_en_use <= 0;
		done <= 0;
		COUNT <= 7'd0;
		COUNT_INIT <= 6'd3;
		x_in <= 0;
		y_in <= 0;
	end
	else begin
		case(STATE)
			IDLE:     begin
								COUNT_INIT <= COUNT_INIT;
							if(clk_en) begin
								STATE <= PROCESS;
								done <= 1'b0;
								x_in <= dataa;
								y_in <= datab;
								clk_en_use <= 1'b1;
							end
						 end
			PROCESS:  begin
						 if(COUNT_INIT < INIT_BOUND1) 
						 begin
							 tick <= 1'b0;
							 COUNT_INIT <= COUNT_INIT + 6'b1;
						 end
						 else if(COUNT_INIT < INIT_BOUND2)
						 begin
							 tick <= 1'b1;
							 COUNT_INIT <= COUNT_INIT + 6'b1;
						 end
						 else if(COUNT_INIT >= INIT_BOUND2)
						 begin
							 tick <= 1'b0;
							 COUNT_INIT <= COUNT_INIT;
						 end
							if(clk_en) begin
								if(N == 8'b1)
								begin
								  STATE <= FINISH;
								  x_in <= dataa;
								  y_in <= datab;
								end
								else
								begin
								  done <= ~done;
								  STATE <= PROCESS;
								  x_in <= (start == 1) ? dataa : 0;
								  y_in <= (start == 1) ? datab : 0;
								end
							end
							
						 end
			FINISH:   begin
							if(clk_en) begin
								if(COUNT < CYCLE_DELAY)
								begin
									STATE <= FINISH;
									COUNT <= COUNT + 7'b1;
									done <= 1'b0;
									x_in <=	0;
									y_in <=	0;
								end
								else if(COUNT == CYCLE_DELAY)
								begin
									STATE <= FINISH;
									done <= 1'b1;
									x_in <=	0;
									y_in <=	0;
									COUNT <= COUNT + 7'b1;
								end
								else
								begin
									STATE <= IDLE;
									COUNT <= 7'd0;
									COUNT_INIT <= 6'b0;
									done <= 1'b0;
									clk_en_use <= 0;
								end
							 end
							end
			default: begin
				STATE <= 0;
				clk_en_use <= 0;
				done <= 0;
				COUNT <= 7'd0;
				COUNT_INIT <= 0;
				x_in <= 0;
				y_in <= 0;
			end
			endcase
	end
end


PE PE1
(
	.clk(clk),
	.aclr(aclr),
	.clk_en(clk_en_use),
	.x_in(x_in),
	.y_in(y_in),
	.tick(tick),
	.out(result)	
);

endmodule
