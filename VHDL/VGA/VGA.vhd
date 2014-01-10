
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY VGA IS
PORT(   
		clk		: IN STD_LOGIC;		
		hsync,
		vsync,
		red0,   
		red1,
		red2, 
		green0,
		green1,
		green2,
		blue0,
		blue1 : OUT STD_LOGIC);		
end VGA;

ARCHITECTURE behavior of VGA IS

SIGNAL clk25	:STD_LOGIC;

SIGNAL 	h_sync, v_sync	:	STD_LOGIC;

SIGNAL 	video_en, horizontal_en, vertical_en	: STD_LOGIC;

SIGNAL	red_signal0,red_signal1,red_signal2,
		green_signal0,green_signal1,green_signal2,
		blue_signal0,blue_signal1	: STD_LOGIC;

SIGNAL 	h_cnt, 
		v_cnt : STD_LOGIC_VECTOR(9 DOWNTO 0);
		
		
BEGIN
	
video_en <= horizontal_en AND vertical_en;


process (clk)
begin
	if clk'event and clk='1' then
	  if (clk25 = '0')then
	    clk25 <= '1';
	  else
	    clk25 <= '0';
		end if;
	end if;
end process;	

PROCESS
variable cnt: integer range 0 to 25000000;

BEGIN

	WAIT UNTIL(clk25'EVENT) AND (clk25 = '1');
	IF(cnt = 25000000)THEN	
	cnt := 0;
	ELSE
	cnt := cnt  + 1;
	END IF;
	


	IF (h_cnt >= 0) AND (h_cnt <= 240) THEN  
		red_signal0 <= '1';
		red_signal1 <= '1';
		red_signal2 <= '1';
		green_signal0 <= '1';
		green_signal1 <= '1';
		green_signal2 <= '1';
		blue_signal0 <= '1';
		blue_signal1 <= '1';
	END IF;	
			
	IF (h_cnt >= 239) AND (h_cnt <= 399) THEN 
		red_signal0 <= '0';
		red_signal1 <= '0';
		red_signal2 <= '0';
		green_signal0 <= '1';
		green_signal1 <= '1';
		green_signal2 <= '1';
		blue_signal0 <= '0';
		blue_signal1 <= '0';		
	END IF;	
	
	IF (h_cnt >= 400) AND (h_cnt <= 479) THEN 
		red_signal0 <= '1';
		red_signal1 <= '1';
		red_signal2 <= '1';
		green_signal0 <= '0';
		green_signal1 <= '0';
		green_signal2 <= '0';
		blue_signal0 <= '0';
		blue_signal1 <= '0';		
	END IF;
	
	IF (h_cnt >= 480) AND (h_cnt <= 799) THEN 
		red_signal0 <= '0';
		red_signal1 <= '0';
		red_signal2 <= '0';
		green_signal0 <= '0';
		green_signal1 <= '0';
		green_signal2 <= '0';
		blue_signal0 <= '1';
		blue_signal1 <= '1';		
	END IF;		
                               
	IF (h_cnt <= 755) AND (h_cnt >= 659) THEN 
		h_sync <= '0';
	ELSE
		h_sync <= '1';
	END IF;
	

	
	IF (h_cnt = 799) THEN
		h_cnt <= "0000000000";
	ELSE
		h_cnt <= h_cnt + 1;
	END IF;
	
	IF (v_cnt >= 524) AND (h_cnt >= 699) THEN   
		v_cnt <= "0000000000";
	ELSIF (h_cnt = 699) THEN
		v_cnt <= v_cnt + 1;
	END IF;
	
		                                         
	IF (v_cnt <= 494) AND (v_cnt >= 493) THEN --产生垂直同步
		v_sync <= '0';	
		
	ELSE
		v_sync <= '1';
	END IF;
	
	
	IF (h_cnt <= 639) THEN                   
		horizontal_en <= '1';

	ELSE
		horizontal_en <= '0';
	END IF;
			
	IF (v_cnt <= 479) THEN                  
		vertical_en <= '1';
	ELSE
		vertical_en <= '0';
	END IF;
	

	red0		<= red_signal0 AND video_en;
	red1		<= red_signal1 AND video_en;
	red2		<= red_signal2 AND video_en;
	green0  <= green_signal0 AND video_en;
	green1  <= green_signal1 AND video_en;
	green2  <= green_signal2 AND video_en;
	blue0	<= blue_signal0 AND video_en;
	blue1	<= blue_signal1 AND video_en;	
	hsync	<= h_sync;
	vsync	<= v_sync;
	
END PROCESS;
END behavior;
