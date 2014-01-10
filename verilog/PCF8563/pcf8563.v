module pcf8563(sysclk,reset,sda,scl,reg_led_second,reg_led_minute);

input sysclk,reset;
inout sda,scl;
output[8:1] reg_led_second,reg_led_minute;

reg sda_buf,scl_buf;
assign sda=sda_buf;
assign scl=scl_buf;

reg clock,shift_clk;
reg[3:0] code_led ;
reg[8:1] reg_led_second,reg_led_minute;
reg[8:0] current_state;


//定义状态机的各子状态；
parameter prepare=0;
parameter start=1;
parameter transmit_slave_address=2;
parameter check_ack1=3;
parameter transmit_sub_address=4;
parameter check_ack2=5;
parameter transmit_data=6;
parameter check_ack3=7;
parameter transmit_data1=8;
parameter transmit_data2=9;
parameter check_ack4=10;
parameter check_ack44=11;
parameter start1=12;
parameter start2=13;
parameter transmit_slave_address1=14;
parameter transmit_slave_address2=15;
parameter transmit_sub_address1=16;
parameter check_ack5=17;
parameter check_ack6=18;
parameter check_ack7=19;
parameter read_data1=20;
parameter check_ack8=21;
parameter read_data2=22;
parameter stop=23;

//定义信号；
reg[8:1] slave_address1=8'b10100010,
         sub_address1=8'b00000000,
         data1=8'b00000000,
         slave_address2=8'b10100011,
         sub_address2=8'b00000010;
reg[1:0] cnt;
reg[3:0] cnt1 = 8;
reg[5:0] count1;
reg[20:0] count;
reg[20:0] cnt2;
reg[1:0] cnt3;

always@(posedge sysclk)  //进程1，分频得到f为4khz的时钟信号
begin
   if (reset==0) count<=0;
   else 
       begin
       count<=count+1;
       if (count<6500)  clock<=1;
       else if (count<12500) clock<=0;           
       else count<=0;            //frequency:4kHz 
       end
end 

always@(posedge clock) //进程2，状态机的转换
begin
if (reset==0)     
    begin 
	count1=0;
	cnt<=0;
	cnt1=8;
	sda_buf<=1;
	scl_buf<=1;
	slave_address1<=8'b10100010;
	slave_address2<=8'b10100011;
	sub_address1<=8'b00000000; 
	sub_address2<=8'b00000010;
	current_state<=prepare;
	data1<=8'b00000000;  
	reg_led_minute<=8'b11111111;
	reg_led_second<=8'b11111111;
	end
else
	begin
    case(current_state)
	prepare: begin              //准备状态，等各个器件复位
			 cnt<=cnt+1;       
             if (cnt==2) 
             begin 
             cnt<=0;
             current_state<=start;
             end
             else current_state<=prepare;
			 end
	/*************初始化开始*********************************************************/		 
	start:  begin
            count1=count1+1;          //起始信号产生状态
			case (count1)
			 1 :sda_buf<=1;
			 2 :scl_buf<=1;
			 3 :sda_buf<=0;
			 4 :scl_buf<=0;
			 5 :begin count1=0;current_state<=transmit_slave_address; end
			 default;
			endcase
			end	
	transmit_slave_address:             //发送器件从地址
             begin
             count1=count1+1;
             case (count1)
			 1 :sda_buf<=slave_address1[cnt1]; //FROM 8BIT TO 1BIT slave_address1:="10100010";
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack1;
                 end
                 else current_state<=transmit_slave_address;
				end
			 default;
			 endcase
			 end
			 
	check_ack1:  begin              //查询应答信号
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=0;
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin count1=0;current_state<=transmit_sub_address; end
			 default;
			endcase
			end     
			
	transmit_sub_address:          //发送器件子地址
			begin
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=sub_address1[cnt1];
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack2;
                 end
                 else current_state<=transmit_sub_address;
				end
			 default;
			 endcase
			 end                      		 

 	check_ack2:  begin            //查询应答信号
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=0;
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin count1=0;current_state<=transmit_data; end
			 default;
			endcase
			end   
			
	transmit_data:        //发送数据
			begin
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=data1[cnt1];
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack3;
                 end
                 else current_state<=transmit_data;
				end
			 default;
			 endcase
			 end    
			 
 	check_ack3:  begin                //查询应答信号
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=0;
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin count1=0;current_state<=transmit_data1; end
			 default;
			endcase
			end   
			
	transmit_data1:            //发送数据
			begin
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=data1[cnt1];
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack4;
                 end
                 else current_state<=transmit_data1;
				end
			 default;
			 endcase
			 end    
			 
 	check_ack4:  begin            //查询应答信号
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=0;
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin count1=0;current_state<=transmit_data2; end
			 default;
			endcase
			end 
			
	transmit_data2:            //发送数据
			begin
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=data1[cnt1];
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack44;
                 end
                 else current_state<=transmit_data2;
				end
			 default;
			 endcase
			 end    
			 
 	check_ack44:  begin         //查询应答信号
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=0;
			 2 :scl_buf<=1;
			 3 :scl_buf<=0;
			 4 :begin count1=0;current_state<=start1; end
			 default;
			endcase
			end  
	/***************************************循环读秒地址和分地址*************/		
	start1:  begin           //起始信号产生状态
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=1;
			 3 :scl_buf<=1;
			 5 :sda_buf<=0;
			 7 :scl_buf<=0;
			 9 :begin count1=0;current_state<=transmit_slave_address1; end
			 default;
			endcase
			end
						
   transmit_slave_address1:   //发送器件从地址
			begin
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=slave_address1[cnt1];
			 3 :scl_buf<=1;
			 6 :scl_buf<=0;
			 8 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack5;
                 end
                 else current_state<=transmit_slave_address1;
				end
			 default;
			 endcase
			 end   
			  
 	check_ack5:  begin    //查询应答信号
            count1=count1+1;
			case (count1)
			 3 :sda_buf<=0;
			 6 :scl_buf<=1;
			 8 :scl_buf<=0;
			 10 :begin count1=0;current_state<=transmit_sub_address1; end
			 default;
			endcase
			end  
				
    transmit_sub_address1:  //发送器件子地址
			begin
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=sub_address2[cnt1];
			 3 :scl_buf<=1;
			 6 :scl_buf<=0;
			 9 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack6;
                 end
                 else current_state<=transmit_sub_address1;
				end
			 default;
			 endcase
			 end   
			  
 	check_ack6:  begin  //查询应答信号
            count1=count1+1;
			case (count1)
			 3 :sda_buf<=0;
			 6 :scl_buf<=1;
			 8 :scl_buf<=0;
			 10 :begin count1=0;current_state<=start2; end
			 default;
			endcase
			end  

	start2:  begin  //重新起始信号产生状态
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=1;
			 3 :scl_buf<=1;
			 6 :sda_buf<=0;
			 8 :scl_buf<=0;
			 10 :begin count1=0;current_state<=transmit_slave_address2; end
			 default;
			endcase
			end   

    transmit_slave_address2:  //发送器件从地址
			begin
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=slave_address2[cnt1];
			 3 :scl_buf<=1;
			 6 :scl_buf<=0;
			 8 :begin 
				 count1=0;
				 cnt1=cnt1-1; 
				 if (cnt1 ==0) 
				 begin
				 cnt1=8;
                 current_state<=check_ack7;
                 end
                 else current_state<=transmit_slave_address2;
				end
			 default;
			 endcase
			 end   
			 
 	check_ack7:  begin               //查询应答信号
            count1=count1+1;
			case (count1)
			 3 :sda_buf<=0;
			 6 :scl_buf<=1;
			 8 :scl_buf<=0;
			 10 :begin count1=0;current_state<=read_data1; end
			 default;
			endcase
			end  
 
  	read_data1:  begin                 //读操作
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=1'bz;
			 4 :scl_buf<=1;
			 8 :reg_led_second[cnt1]<=sda;
			 10 :scl_buf<=0;
			 12 :
				begin 
				cnt1=cnt1-1;
				count1=0;
				if (cnt1==0) 
					begin
					cnt1=8; 
					current_state<=check_ack8;
					end
				else current_state<=read_data1;
				end
			 default;
			endcase
			end 
			 
 	check_ack8:  begin        //查询应答信号
            count1=count1+1;
			case (count1)
			 3 :sda_buf<=0;
			 6 :scl_buf<=1;
			 8 :scl_buf<=0;
			 10 :begin count1=0;current_state<=read_data2; end
			 default;
			endcase
			end  
 
  	read_data2:  begin         //读操作
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=1'bz;
			 4 :scl_buf<=1;
			 8 :reg_led_minute[cnt1]<=sda;
			 10 :scl_buf<=0;
			 12 :
				begin 
				cnt1=cnt1-1;
				count1=0;
				if (cnt1==0) 
					begin
					cnt1=8; 
					current_state<=stop;
					end
				else current_state<=read_data2;
				end
			 default;
			endcase
			end   
			           
 	stop :  begin          //产生停止信号
            count1=count1+1;
			case (count1)
			 1 :sda_buf<=0;
			 3 :scl_buf<=1;
			 10 :sda_buf<=1;
			 15 :begin count1=0;current_state<=start1; end
			 default;
			endcase
			end  			
	                        		 
	endcase
	end
end   	                 		 
endmodule