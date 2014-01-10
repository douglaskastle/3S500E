module ds18b20_seg7(
  input        CLOCK_50,               
  input        Q_KEY,                  

  inout        DS18B20,
 
  output [7:0] SEG7_SEG,               
  output [3:0] SEG7_SEL                
);


wire [15:0] t_buf;

ds18b20_drive ds18b20_u0(
  .clk(CLOCK_50),
  .rst_n(Q_KEY),
  .one_wire(DS18B20),
  .temperature(t_buf)
);
seg_dynamic_drive seg7_u0(
  .clk         (CLOCK_50),
  
  .data       	({t_buf[11:8],t_buf[7:4],t_buf[3:0],4'h0}),
  .dp    		(4'b1011),
  .SEG       	(SEG7_SEG),
  .SEG_S     	(SEG7_SEL)
);
endmodule
