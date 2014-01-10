module VGA(
   clk,
   red0,   
   red1,
   red2, 
   green0,
   green1,
   green2,
   blue0,
   blue1, 
   hsync,
   vsync
);
input  clk;     
output  red0,red1,red2,green0,green1,green2,blue0,blue1;   
output  hsync;     
output  vsync;    

reg [9:0] hcount;    
reg [9:0] vcount;    
reg [8:0] data;     

reg   flag;
wire  hcount_ov;
wire  vcount_ov;
wire  dat_act;
wire  hsync;
wire  vsync;
reg  vga_clk;


parameter hsync_end   = 10'd95,
   hdat_begin  = 10'd143,
   hdat_end  = 10'd783,
   hpixel_end  = 10'd799,
   vsync_end  = 10'd1,
   vdat_begin  = 10'd34,
   vdat_end  = 10'd514,
   vline_end  = 10'd524;


always @(posedge clk)
begin
 vga_clk = ~vga_clk;
end



    
always @(posedge vga_clk)
begin
 if (hcount_ov)
  hcount <= 10'd0;
 else
  hcount <= hcount + 10'd1;
end
assign hcount_ov = (hcount == hpixel_end);


always @(posedge vga_clk)
begin
 if (hcount_ov)
 begin
  if (vcount_ov)
   vcount <= 10'd0;
  else
   vcount <= vcount + 10'd1;
 end
end
assign  vcount_ov = (vcount == vline_end);


assign dat_act =    ((hcount >= hdat_begin) && (hcount < hdat_end))
                     && ((vcount >= vdat_begin) && (vcount < vdat_end)); 
assign hsync = (hcount > hsync_end);
assign vsync = (vcount > vsync_end);
assign {red0,red1,red2,green0,green1,green2,blue0,blue1} = (dat_act) ?  data : 3'h00;
     
 

always @(posedge vga_clk) 
begin
 if(hcount < 223)
  data  <= 8'b11111111;       
 else if(hcount < 303)
  data  <= 8'b11111100;   
 else if(hcount < 403)
  data  <= 8'b00011100;   
 else if(hcount < 783)
 data  <= 8'b01111100; 
 else 
  data  <= 8'b00000000;   
end

endmodule

