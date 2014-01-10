module data_ctl(
//input signals
input     clk,
input     rst,
input  [15:0] readdata,

output  reg   wr_req,
output  reg   rd_req,
output  reg  [21:0] addr,   //from bus
output  reg  [15:0] data, //from bus   
output  reg   led
);

reg [21:0] cnt;
reg [21:0] div;
reg [7:0] i_led;
reg [31:0] counter_led;

always @(posedge clk or negedge rst) 
begin
	if(!rst) 
	   div<=0;
	else
	   div<=div+1;
end


always @(posedge div[6] or negedge rst)    
begin
	 if(!rst) 
		begin
			addr<=0;
			data<=0;
			wr_req<=1;
			rd_req<=0;
			cnt<=0;
			led<=1;
		end
	 else 
		 begin
			 cnt<=cnt+1;
			 if( cnt <200);
				begin
					wr_req<=1;
					rd_req<=0;
					addr<=1;
					data<=100;
				end
			 if( cnt >=200 && cnt <=399)
				begin
					wr_req<=0;
					rd_req<=1;
					addr<=1;
				end   
			  if(cnt == 399)
				cnt<=0;
				if(readdata==100)begin
				               if (counter_led == 32'd25000000) 
									begin
											counter_led <= 32'd0;
											if(i_led==8'd1)i_led<=8'd0;
											else i_led<=i_led+8'd1;
									end
									else counter_led <= counter_led + 32'd1;
									case(i_led) 
												 8'd0:  begin led <= 0;    end
												 8'd1:  begin led <= 1;    end
									endcase
									end
				else
				led<=0;
	         
		 end
 end


endmodule