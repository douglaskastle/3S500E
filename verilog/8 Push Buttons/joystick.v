module joystick(
					clk,
					reset,
					key,
					led
               );
input clk,reset;
input [7:0]key;
output[3:0] led;

reg[3:0] led_reg;
reg[10:0] Count1;
reg  Count;
always@(posedge clk or negedge reset)
if(!reset)
Count1<=11'd0;
else if(Count1==11'd1999)
Count=~Count;
else 
Count1<=Count1+1'b1;


always@(posedge Count or negedge reset)
if(!reset)
led_reg<=4'b1111;
else if(key==8'b11111110)
led_reg<=4'b1110;
else if(key==8'b11111101)
led_reg<=4'b1101;
else if(key==8'b11111011)
led_reg<=4'b1100;
else if(key==8'b11110111)
led_reg<=4'b1011;

else if(key==8'b11101111)
led_reg<=4'b1010;
else if(key==8'b11011111)
led_reg<=4'b1001;
else if(key==8'b10111111)
led_reg<=4'b1000;
else if(key==8'b01111111)
led_reg<=4'b0111;
else
led_reg<=led_reg;

assign led=led_reg;

endmodule
