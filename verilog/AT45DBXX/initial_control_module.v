module initial_control_module
(
    CLK, RSTn,
	 SPI_Done_Sig,
	 SPI_Start_Sig,
	 SPI_Data,
	 SPI_Rdata,
	 led
);

    input CLK;
	 input RSTn;
	 input [7:0] SPI_Rdata;
	 input SPI_Done_Sig;
	 output SPI_Start_Sig;
	 output [8:0]SPI_Data;
	  output reg [3:0]led;
	 
	 /************************/
	 
	 reg [7:0]i;
	 reg [8:0]rData;
	 reg isSPI_Start;
	 reg [4:0]WData=0;
	 reg [31:0] delay_cnt;
	 always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )
		      begin
		          i <= 8'd0;
				    rData <= { 2'b11, 8'h2f };
					 isSPI_Start <= 1'b0;
				end	 

		  else if( 1 )
		      case( i )
						/**********************************write***********************/
                8'd0: 
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 1'b0, 8'h84 }; isSPI_Start <= 1'b1; end
					 
					 8'd1:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 1'b0, 8'hff }; isSPI_Start <= 1'b1; end
					 
					 8'd2:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 1'b0, 8'h00 }; isSPI_Start <= 1'b1; end
					 
					 8'd3:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 1'b0, 4'b0000,WData[3:0] }; isSPI_Start <= 1'b1; end//WData[3:0] 
					 
					 8'd4: 
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= 5; WData<= WData+1'b1;end
					 else begin rData <= { 1'b0, 4'b0000,WData[3:0] }; isSPI_Start <= 1'b1; end
					 
					 8'd5:
					 if(WData==16)begin
											
											delay_cnt<=delay_cnt+1;
											if(delay_cnt==12500000) begin 
														i <=6;delay_cnt<=0;WData <=0;
											end
											else i <=5;
							end
					 else begin 
										rData[8]<=1'b1; 
										 led<=~WData[3:0] ;       //show  the writed data  by  leds
										delay_cnt<=delay_cnt+1;
										  if(delay_cnt==7500000) begin
											   i <=0; delay_cnt<=0;
											end
											else i <=5;
								end
					 
					 
					  /**********************************read1***********************/
					 8'd6:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 1'b0, 8'hD4 }; isSPI_Start <= 1'b1; end
					 
					 8'd7:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 1'b0, 8'hFF }; isSPI_Start <= 1'b1; end
					 
					 8'd8:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 1'b0, 8'h00 }; isSPI_Start <= 1'b1; end
					 
					 8'd9:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= 10; end
					 else begin rData <= { 1'b0, 4'b0000,WData[3:0]  }; isSPI_Start <= 1'b1; end
					 
					 8'd10:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= 12; end
					 else begin rData <= { 1'b0, 8'hff}; isSPI_Start <= 1'b1; end
					 
					 /****read and  showed  by  leds****/
					 8'd12:
					 if( SPI_Done_Sig ) begin led<=~SPI_Rdata;isSPI_Start <= 1'b0; i <= 11; end
					 else begin rData <= { 1'b0, 8'h00 }; isSPI_Start <= 1'b1; end
					 
					 8'd11:begin
													delay_cnt<=delay_cnt+1;
													if(delay_cnt==12750) begin 
															delay_cnt<=0;i <=19;
													end
							end
					 
					 19:
							if(WData==16)begin
							i <=20;  WData <=0; 
							end
							else begin 	
													rData[8]<=1'b1; 
													delay_cnt<=delay_cnt+1;
													if(delay_cnt==25000000) begin 
															delay_cnt<=0;i <=6;WData<= WData+1'b1;
													end
													else i<=19;

								end
					 
					 20:
					 begin rData <= { 1'b1, 8'hff };   end
				
				endcase
				
	 /***********************************/
	 
	 assign SPI_Start_Sig = isSPI_Start;
	 assign SPI_Data = rData;
	 
	 /*************************************/
	 
endmodule
