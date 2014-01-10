module seg_7(
	input [3:0] data,
	output [6:0] seg
	);
	
	reg [6:0] seg2;
	assign seg = ~seg2;
	
	always@(*) begin
		case(data)
			4'h0: seg2 = 7'b1111110;//0x01
			4'h1: seg2 = 7'b0110000;//0x4f
			4'h2: seg2 = 7'b1101101;//0x12
			4'h3: seg2 = 7'b1111001;//0x06
			4'h4: seg2 = 7'b0110011;//0x
			4'h5: seg2 = 7'b1011011;//0x24
			4'h6: seg2 = 7'b1011111;//5f
			4'h7: seg2 = 7'b1110000;//70
			4'h8: seg2 = 7'b1111111;//7f
			4'h9: seg2 = 7'b1111011;//7b
			4'hA: seg2 = 7'b1110111;
			4'hB: seg2 = 7'b0011111;
			4'hC: seg2 = 7'b1001110;
			4'hD: seg2 = 7'b0111101;
			4'hE: seg2 = 7'b1001111;
			4'hF: seg2 = 7'b1000111;
			default: seg2 = 0;
		endcase
	end
	
endmodule