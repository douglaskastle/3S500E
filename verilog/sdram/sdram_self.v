/*******************************************************************
*Project Name  :sdram
*Module  Name :sdram
*Target Device :EP1C6Q240C8
*Clkin   :50M
*Desisgner  :kang
*Date    :2010-12-01
*Version   :1.00
*Descriprion :sdram controller
*Additional Comments :  sdram controller works at 125M HZ.
*******************************************************************/
module sdram_self(
//input signals
input     clk,
input     rst,
input     wr_req,
input     rd_req,
input    [21:0] addr,   //from bus
input    [15:0] data_write, //from bus
//output signals
output    cs_n,
output     cas_n,
output     ras_n,
output     cke,
output reg [1:0] ba,
output reg [11:0] add,   //give sdram
output    we_n,
output   [1:0] dqm,
output    wr_ack,
output    rd_ack,
output     busy,
output  [15:0]  data_read,
output        wr_done,
output        rd_done,
//inout signals
inout    [15:0] dq  
    );

//Initial state machine parameters    
parameter  INIT_NOP =4'd0,
    INIT_PRE =4'd1,
    INIT_AR =4'd2,
    INIT_MRS =4'd3,
    INIT_CNT =4'd4,
    INIT_DONE=4'd5;

//Work state machine parameters
parameter WORK_IDLE =4'd0,
    WORK_ACTIVE =4'd1,
    WORK_READ =4'd2,
    WORK_RD  =4'd3,
    WORK_RWAIT =4'd4,
    WORK_WRITE =4'd5,
    WORK_WD  =4'd6,
    WORK_TDAL =4'd7,
    WORK_AR  =4'd8;

//Command parameters
parameter CMD_INIT   =5'b01111, //Initial after power on
    CMD_NOP   =5'b10111, //NOP command
    CMD_ACTIVE  =5'b10011, //ACTIVE command
    CMD_READ   =5'b10101, //READ command
    CMD_WRITE  =5'b10100, //WRITE command
    CMD_BURSTSTOP =5'b10110, //BURST stop
    CMD_PRECHARGE =5'b10010, //precharge
    CMD_AUTOREFRESH=5'b10001, //auto refersh
    CMD_LOADMODEREG=5'b10000; //load mode register
   
//timing parameters
parameter  TRP_CLK =4'd4,    //precharge
    TRFC_CLK =4'd6,    //refresh
    TMRD_CLK =4'd6,    //load mode register
    TRCD_CLK =4'd2,    //row to column delay
    TCL_CLK =4'd3,    //cas latency
    TREAD_CLK=4'd8,    //read
    TWRITE_CLK=4'd8,    //write
    TDAL_CLK =4'd3;    //after write,wait clock num

/**********************************************************************
******************from here starts the control code********************
***********************************************************************/


/***********************************************************************
//delay 200us after power on
//this counter depends on the work frequency
//default:125M HZ
***********************************************************************/

//counter_200us
reg [14:0] counter_200us;
always @(posedge clk or negedge rst)    
 begin
 if(!rst) counter_200us<=0;
 else if(counter_200us<15'd25000) counter_200us<=counter_200us+1'b1;
 end

//done_200us
wire done_200us;
assign done_200us=(counter_200us>=15'd25000);

/********************************************************************** 
//command assignments
//command is made up of cke,cs_n,ras_n,cas_n,we_n
//command's value is produced by the work state machine
**********************************************************************/

reg [4:0] command; 
assign {cke,cs_n,ras_n,cas_n,we_n}=command; 

/**********************************************************************
//Initial state machine
//this state machine is only avaliable after power on,and only runs once
//when this state machine runs over,then the controller runs in the work state machine
//
***********************************************************************/

reg [3:0] init_nextstate; //next state
reg [3:0] init_state;  //current state
reg [4:0] init_counter; //this counter is used to make delay in the initial state machine
reg [4:0] init_cmd; //cmd in the initial state machine
reg [1:0] init_ba; //
reg [11:0] init_addr;//
reg [3:0] refresh_counter;
always @(posedge clk or negedge rst)
 begin
 if(!rst)       //
  begin
  init_cmd<=CMD_INIT;
  init_ba<=2'b11;
  init_addr<=12'hfff;
  init_state<=INIT_NOP;
  init_state<=INIT_NOP;
  init_counter<=0;
  refresh_counter<=0;
  end
 else
  begin
  case(init_state)
  INIT_NOP :     //wait 200us after power on, and then go the the next state
   begin
   init_cmd<=CMD_NOP;
   init_ba<=2'b11;
   init_addr<=12'hfff;
   if(done_200us) init_state<=INIT_PRE;
   end
  INIT_PRE :     //precharge
   begin
   init_cmd<=CMD_PRECHARGE;
   init_ba<=2'b11;
   init_addr<=12'hfff;
   init_counter<=TRP_CLK;
   init_state<=INIT_CNT;
   init_nextstate<=INIT_AR;
   end
  INIT_AR:     //auto refresh, in the initial state,we run auto refresh 3 times
   begin
   init_ba<=2'b11;
   init_addr<=12'hfff;
   init_counter<=TRFC_CLK;
   if(refresh_counter==4'h7) 
     begin
     init_state<=INIT_MRS;
     end
   else 
    begin
    refresh_counter<=refresh_counter+1'b1;
    init_cmd<=CMD_AUTOREFRESH;
    init_state<=INIT_CNT;
    end
   init_nextstate<=INIT_AR;
   end
  INIT_MRS :     //load the mode register
   begin
   init_cmd<=CMD_AUTOREFRESH;
   init_ba<=2'b00;
   init_addr<={
       2'b00,  //a11=0,a10=0;
       1'b0,   //a9,burst read and write
       2'b00,  //a8=0;a7=0;
       3'b011,  //cas latency=3
       1'b0,   //burst mode set
       3'b011  //burst data length set,here we use the length of 8
       };
   init_counter<=TRFC_CLK;
   init_state<=INIT_CNT;
   init_nextstate<=INIT_DONE;
   end
  INIT_CNT :      //init state machine counter, used to produce delay
   begin
   init_cmd<=CMD_NOP;
   init_ba<=2'b11;
   init_addr<=12'hfff;
   if(init_counter>4'd1) init_counter<=init_counter-1'b1;
   else init_state<=init_nextstate;
   end
  INIT_DONE:      //initial done
    init_state<=INIT_DONE;
  default:
   begin
   init_state<=INIT_NOP;
   init_ba<=2'b11;
   init_addr<=12'hfff;
   end
  endcase
  end
 end

wire sign_init_done;
assign sign_init_done=(init_state==INIT_DONE)?1'b1:1'b0;
 
/*******************************************************************************
//refresh counter 
//sdram need refresh every 64ms,and this chip has 4096 columns
//so we has to fresh every 15.625us
*******************************************************************************/

//counter_15us
reg [10:0] counter_15us;
always @(posedge clk or negedge rst)
 begin
 if(!rst) counter_15us<=0;
 else if(counter_15us>=11'd1875) counter_15us<=0;
 else counter_15us<=counter_15us+1'b1;
 end

//refresh request and answer back
reg refresh_req;  //refresh request
wire refresh_ack;  //refresh answer back
always @(posedge clk or negedge rst)
 begin
 if(!rst) refresh_req<=0;
 else if(counter_15us>=1875) refresh_req<=1'b1;
 else if(refresh_ack) refresh_req<=0;
 end

 
/******************************************************************************* 
//work state machine
//this state machine works at the normal time, including read, write and refresh
//when initial state machine runs over, this machine begin to run
//
*******************************************************************************/
reg [3:0] work_state;    //current state
reg [4:0] work_counter;    //work counter, used to make delay
reg wr_n;        //when write,wr_n=0;when read,wr_n=1;
reg oe;
always @(posedge clk or negedge rst)
 begin
 if(!rst) 
  begin
  command<=CMD_INIT;
  ba<=2'b11;
  add<=12'hfff;
  work_state<=WORK_IDLE;
  work_counter<=0;
  end
 else if(sign_init_done)//when initial state machine done, work state machine begin to run
  begin
  case(work_state)
  WORK_IDLE :     //in the idle state, we will enter autorefresh or active state as the next state
   begin
   command<=CMD_NOP;
   ba<=2'b11;
   add<=12'hfff;
   work_counter<=0;
   if(refresh_req) 
    begin
    work_state<=WORK_AR;
    end
   else if(wr_req) 
    //begin
    //if((prior_rowadd==addr[21:8])&&is_prior_wr) work_state<=WORK_WRITE;
    //else 
     begin
     work_state<=WORK_ACTIVE;     
     wr_n<=0;     
     end
    //end
   else if(rd_req)
    //begin
    //if((prior_rowadd==addr[21:8])&&is_prior_rd) work_state<=WORK_READ;
    //else
     begin
     work_state<=WORK_ACTIVE;
     wr_n<=1'b1;
     end 
    //end
   else work_state<=WORK_IDLE;
   end
  WORK_ACTIVE :     //write the row address,and wait TRCD_CLK clks
   begin
   ba<=addr[21:20];
   add<=addr[19:8];
   if(work_counter>=TRCD_CLK)
    begin
    if(wr_n) work_state<=WORK_READ;
    else work_state<=WORK_WRITE;
    work_counter<=0;
    end
   else
    begin
    if(work_counter==0) command<=CMD_ACTIVE;
    else command<=CMD_NOP;
    work_state<=WORK_ACTIVE;
    work_counter<=work_counter+1'b1;
    end
   end
  WORK_READ :     //read. wait TCL_CLK clks, then enter WORK_RD
   begin
   ba<=addr[21:20];
   add<={
     4'b0100,    //A10=1;allow precharge after write
     addr[7:0]   //column address
     };
   if(work_counter>=(TCL_CLK))
    begin
    work_state<=WORK_RD;
    work_counter<=0;
    end
   else 
    begin
    work_state<=WORK_READ;
    work_counter<=work_counter+1'b1;
    end
   if(work_counter==0) command<=CMD_READ;
   else command<=CMD_NOP;
   end
  WORK_RD  :     //read data
   begin
   command<=CMD_NOP;
   if(work_counter>=(TREAD_CLK-1'b1))
    begin
    work_state<=WORK_RWAIT;
    work_counter<=0;
    end
   else 
    begin
    work_state<=WORK_RD;
    work_counter<=work_counter+1'b1;
    end
   end
  WORK_RWAIT :     //read wait
   begin
   command<=CMD_NOP;
   if(work_counter>=(TRP_CLK))
    begin
    work_state<=WORK_IDLE;
    work_counter<=0;
    end
   else 
    begin
    work_state<=WORK_RWAIT;
    work_counter<=work_counter+1'b1;
    end
   end
  WORK_WRITE :     //write
   begin
   command<=CMD_WRITE;
   ba<=addr[21:20];
   add<={
     4'b0100,    //A10=1;allow precharge after write
     addr[7:0]   //column address
     };
   work_state<=WORK_WD; 
   end
  WORK_WD  :     //write data
   begin
   command<=CMD_NOP;
   if(work_counter>=(TWRITE_CLK-1'b1))
    begin
    work_state<=WORK_TDAL;
    work_counter<=0;
    end
   else 
    begin
    work_state<=WORK_WD;
    work_counter<=work_counter+1'b1;
    end
   end
  WORK_TDAL :     //write delay
   begin
   command<=CMD_NOP;
   if(work_counter>=TDAL_CLK)
    begin
    work_state<=WORK_IDLE;
    work_counter<=0;
    end
   else 
    begin
    work_state<=WORK_TDAL;
    work_counter<=work_counter+1'b1;
    end
   end
  WORK_AR  :     //auto refresh
   begin
   if(work_counter==0) command<=CMD_AUTOREFRESH;
   else command<=CMD_NOP;
   ba<=2'b11;
   add<=12'hfff;
   if(work_counter==TRFC_CLK)
    begin
    work_state<=WORK_IDLE;
    work_counter<=0;
    end
   else 
    begin
    work_state<=WORK_AR;
    work_counter<=work_counter+1'b1;
    end
   end
  default:
   begin
   command<=CMD_NOP;
   work_state<=WORK_IDLE;
   work_counter<=0;
   end
  endcase
  end
 else          //when in initial state, all parameters are equaled to the initial state 
  begin
  command<=init_cmd;
  ba<=init_ba;
  add<=init_addr;
  work_counter<=0;
  end
 end

assign busy=(sign_init_done&&(work_state==WORK_IDLE))?1'b0:1'b1;
assign refresh_ack=(work_state==WORK_AR);
assign wr_ack=(work_state==WORK_WD);
assign rd_ack=(work_state==WORK_RD);
assign wr_done=(work_state==WORK_TDAL)&&(work_counter==5'd0);
assign rd_done=(work_state==WORK_RWAIT)&&(work_counter==5'd0);

assign data_read=dq;

assign dq=((work_state==WORK_WD)||(work_state==WORK_WRITE)||(work_state==WORK_TDAL))?data_write:16'hzzzz;

assign dqm=2'b00;
 
endmodule


