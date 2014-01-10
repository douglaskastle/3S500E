module sel_4(
	input clk,
	input nrst,
	input [15:0] number,
	output reg [3:0] sel,
	output [6:0] seg
);

reg [3:0] data;
reg [31:0] count1;
reg sel_clk;

always@(posedge clk, negedge nrst)
begin
	if(!nrst) begin
		count1 <= 0;
		sel_clk <= 0;
	end
	else if(count1==50000) begin	//10ms delay
		count1 <= 0;
		sel_clk <= ~sel_clk;
	end
	else begin
		count1 <= count1 + 1;
	end
end

always@(posedge sel_clk, negedge nrst)
begin
	if(!nrst) begin
		sel <= 4'b0001;
	end
	else if(sel == 4'b1000) begin
		sel <= 4'b0001;
	end
	else begin
		sel <= sel << 1;
	end
end

always@(*)
begin
	case(sel)
		4'b0001: data = number[3:0];
		4'b0010: data = number[7:4];
		4'b0100: data = number[11:8];
		4'b1000: data = number[15:12];
		default: data = 0;
	endcase
end

seg_7 output_seg(
	.data(data),
	.seg(seg)
);

endmodule