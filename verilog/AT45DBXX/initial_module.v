module initial_module
(
    CLK, RSTn,
	 SPI_Out,SPI_In,led
);

    input CLK;
	 input SPI_In;
	 input RSTn;
	 output [2:0]SPI_Out; // [2]CS   [1]CLK [0]DO
		output  [3:0]led;
	 /*******************************/
	 
	 wire SPI_Start_Sig;
	 wire [8:0]SPI_Data;
	 wire [7:0]SPI_Rdata;
	 wire SPI_Done_Sig;
	 
	 initial_control_module U1
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .SPI_Done_Sig( SPI_Done_Sig ),    // input - from U2
		  .SPI_Start_Sig( SPI_Start_Sig ),  // output - to U2
		  .SPI_Data( SPI_Data ),           // output - to U2
		  .SPI_Rdata( SPI_Rdata ),  
		  .led(led)
		  
	 );
	 
	 /********************************/
	 
	 
	 
	 spi_write_module U2
	 (
	     .CLK( CLK ),
		  .SPI_In(SPI_In),
		  .SPI_Rdata(SPI_Rdata),
		  .RSTn( RSTn ),
		  .Start_Sig( SPI_Start_Sig ),    // input - from U1
		  .SPI_Data( SPI_Data ),          // input - from U1
		  .Done_Sig( SPI_Done_Sig ),  // output - to U1
		  .SPI_Out( SPI_Out )             // output - to top
	 );
	 
	 /***********************************/


endmodule
