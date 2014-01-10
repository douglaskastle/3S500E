module joystick(
					clk,
					reset,
					key_up,
					key_down,
					key_left,
					key_right,key_z,
					led
               );
input clk,reset;
input key_up,key_down,key_left,key_right,key_z;
output[3:0] led;

reg[3:0] led_reg=0;
always@(posedge clk or negedge reset)
if(!reset)
led_reg<=4'b1111;
else if(!key_z)
led_reg<=4'b0000;
else if(!key_up)
led_reg<=4'b1110;
else if(!key_down)
led_reg<=4'b0111;
else if(!key_left)
led_reg<=4'b1101;
else if(!key_right)
led_reg<=4'b1011;
else
led_reg<=led_reg;

assign led=led_reg;

endmodule
