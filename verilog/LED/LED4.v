module LED4(
	input nrst,
	input clk,
	output reg [3:0]led
	);
	reg clk2;
	reg [31:0] counter;	
	reg [7:0] i=0;	

	
	always@(posedge clk, negedge nrst) begin
		if(!nrst) begin
			counter <= 0;
			clk2 <= 0;
		end
	  else if (counter == 12500000) begin
			counter <= 0;
			clk2 <= ~clk2;
		end
		else
			counter <= counter + 32'd1;
	end

	always@(posedge clk2, negedge nrst) begin
		if(!nrst) begin
			led = 4'd0;
			i<=0;
			end
		else
			case (i)
		      0:	begin led = 4'b0001;i<=i+1; end
				1:	begin led = 4'b0010;i<=i+1; end
				2:	begin led = 4'b0100;i<=i+1; end
				3:	begin led = 4'b1000;i<=0; end
			endcase	 	
	end
	
endmodule
