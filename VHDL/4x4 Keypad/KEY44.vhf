--------------------------------------------------------------------------------
-- Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 12.2
--  \   \         Application : sch2hdl
--  /   /         Filename : KEY44.vhf
-- /___/   /\     Timestamp : 10/17/2012 13:16:25
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl "E:/Program/XC3S250/VHDL/4x4 Keypad/KEY44.vhf" -w "E:/Program/XC3S250/VHDL/4x4 Keypad/KEY44.sch"
--Design Name: KEY44
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity KEY44 is
   port ( clk     : in    std_logic; 
          reset   : in    std_logic; 
          row     : in    std_logic_vector (3 downto 0); 
          col     : out   std_logic_vector (3 downto 0); 
          DIGIT   : out   std_logic_vector (2 downto 0); 
          LED     : out   std_logic_vector (7 downto 0); 
          XLXN_17 : out   std_logic; 
          XLXN_18 : out   std_logic_vector (7 downto 0));
end KEY44;

architecture BEHAVIORAL of KEY44 is
   signal XLXN_1  : std_logic_vector (3 downto 0);
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   component Frequency
      port ( RESET     : in    std_logic; 
             GCLKP1    : in    std_logic; 
             ClockScan : out   std_logic; 
             KeyScan   : out   std_logic);
   end component;
   
   component LED8
      port ( RESET       : in    std_logic; 
             ClockScan   : in    std_logic; 
             LED1        : in    std_logic_vector (3 downto 0); 
             LED2        : in    std_logic_vector (3 downto 0); 
             LED3        : in    std_logic_vector (3 downto 0); 
             LED4        : in    std_logic_vector (3 downto 0); 
             LED5        : in    std_logic_vector (3 downto 0); 
             LED6        : in    std_logic_vector (3 downto 0); 
             LED7        : in    std_logic_vector (3 downto 0); 
             LED8        : in    std_logic_vector (3 downto 0); 
             light       : out   std_logic_vector (7 downto 0); 
             LEDOut      : out   std_logic_vector (7 downto 0); 
             DigitSelect : out   std_logic_vector (2 downto 0));
   end component;
   
   component key44
      port ( sys_clk : in    std_logic; 
             rst     : in    std_logic; 
             row     : in    std_logic_vector (3 downto 0); 
             valid   : out   std_logic; 
             code    : out   std_logic_vector (3 downto 0); 
             col     : out   std_logic_vector (3 downto 0));
   end component;
   
begin
   XLXI_1 : Frequency
      port map (GCLKP1=>clk,
                RESET=>reset,
                ClockScan=>XLXN_14,
                KeyScan=>XLXN_15);
   
   XLXI_2 : LED8
      port map (ClockScan=>XLXN_14,
                LED1(3 downto 0)=>XLXN_1(3 downto 0),
                LED2(3 downto 0)=>XLXN_1(3 downto 0),
                LED3(3 downto 0)=>XLXN_1(3 downto 0),
                LED4(3 downto 0)=>XLXN_1(3 downto 0),
                LED5(3 downto 0)=>XLXN_1(3 downto 0),
                LED6(3 downto 0)=>XLXN_1(3 downto 0),
                LED7(3 downto 0)=>XLXN_1(3 downto 0),
                LED8(3 downto 0)=>XLXN_1(3 downto 0),
                RESET=>XLXN_16,
                DigitSelect(2 downto 0)=>DIGIT(2 downto 0),
                LEDOut(7 downto 0)=>LED(7 downto 0),
                light(7 downto 0)=>XLXN_18(7 downto 0));
   
   XLXI_4 : key44
      port map (row(3 downto 0)=>row(3 downto 0),
                rst=>XLXN_16,
                sys_clk=>XLXN_15,
                code(3 downto 0)=>XLXN_1(3 downto 0),
                col(3 downto 0)=>col(3 downto 0),
                valid=>XLXN_17);
   
end BEHAVIORAL;


