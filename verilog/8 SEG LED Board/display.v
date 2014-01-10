module display(
	input nrst,
	input clk,
	output [3:0] sel,
	output [6:0] seg
	);
	
	reg [31:0] count1;
	reg [15:0] number;
//	
	always@(posedge clk, negedge nrst) begin
		if(!nrst) begin
			number <= 0;
			count1 <= 0;
		end
		else if(count1 == 25000000) begin
			number <= number + 1;
			count1 <= 0;
		end
		else begin
			count1 <= count1 + 1;
		end
	end
	
sel_4 U1(
	.clk(clk),
	.nrst(nrst),
	.number(number),
	.sel(sel),
	.seg(seg)
);

endmodule