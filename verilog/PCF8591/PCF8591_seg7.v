module ds18b20_seg7(
  input        CLOCK_50,               
  input        Q_KEY,                  

  inout        sda,scl,
 
  output [7:0] SEG7_SEG,               
  output [3:0] SEG7_SEL                
);


wire [15:0] t_buf;


pcf8591 pcf8591_u0(
  .sysclk(CLOCK_50),
  .reset(Q_KEY),
	.sda(sda),
	.scl(scl),
  .reg_ADData(t_buf[15:8]),
  .data1(t_buf[7:0])

);
seg_dynamic_drive seg7_u0(
  .clk         (CLOCK_50),
  .data       	(t_buf),
  .dp    		(4'b1011),
  .SEG       	(SEG7_SEG),
  .SEG_S     	(SEG7_SEL)
);
endmodule
