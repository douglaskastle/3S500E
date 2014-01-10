module ps2_top (clk,rst_n,ps2_data,ps2_clk,en,rs,rw,data,low,clk48hz,shift_o,dis_key_o,keyvalue_o,relase,LCD_N,LCD_P,vled);
	input				clk;
	input				rst_n;
	inout				ps2_data;
	inout				ps2_clk;
	output			en;
	output			rs;
	output			rw,LCD_N,LCD_P;
	output	[7:0]	data;
	output	[3:0]	vled;
	output           low;
	output			clk48hz;
	output			shift_o;
	output			dis_key_o;
	output	[7:0]	keyvalue_o;
	output			relase;
	
	wire				speed;
	wire              key_on;
	wire				shift1;
	wire				capslock;
	wire		[7:0]	keyvalue1;
	assign low = 1'b0;
	assign vled = 4'b1111;
 	lcd U1(	.clk(clk),
 			.rst_n(rst_n),
 			.shift(shift1),
 			.capslock(capslock),
 			.keyvalue(keyvalue1),
 			.key_on(key_on),
 			.speed(speed),
 			.en(en),
 			.rs(rs),
 			.rw(rw),
 			.data(data),
 			.clk48hz(clk48hz),
 			.dis_key(dis_key_o),
 			.shift_o(shift_o),
			.LCD_N(LCD_N),
			.LCD_P(LCD_P),
 			.keyvalue_o(keyvalue_o));
 
 	ps2 U2(	.clk(clk),
			.rst_n(rst_n),
			.ps2_data(ps2_data),
			.ps2_clk(ps2_clk),
			.write(1'b0),
			.error(),
			.key_on(key_on),
			.write_data(8'b0),
			.shift(shift1),
			.capslock(capslock),
			.key_value(keyvalue1),
			.relase(relase),
			.speed(speed)
			);
	
endmodule