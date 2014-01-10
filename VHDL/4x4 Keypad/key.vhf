--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : key.vhf
-- /___/   /\     Timestamp : 01/10/2014 11:25:04
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl "C:/storage/projects/git/3S500E/VHDL/4x4 Keypad/key.vhf" -w "C:/storage/projects/git/3S500E/VHDL/4x4 Keypad/key.sch"
--Design Name: key
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

entity key is
   port ( GCLKP1 : in    std_logic; 
          RESET  : in    std_logic; 
          ROW    : in    std_logic_vector (3 downto 0); 
          COL    : out   std_logic_vector (3 downto 0); 
          DIGIT  : out   std_logic_vector (2 downto 0); 
          LED    : out   std_logic_vector (7 downto 0));
end key;

architecture BEHAVIORAL of key is
   signal XLXN_1  : std_logic;
   signal XLXN_2  : std_logic;
   signal XLXN_10 : std_logic_vector (3 downto 0);
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
      port map (GCLKP1=>GCLKP1,
                RESET=>RESET,
                ClockScan=>XLXN_1,
                KeyScan=>XLXN_2);
   
   XLXI_2 : LED8
      port map (ClockScan=>XLXN_1,
                LED1(3 downto 0)=>XLXN_10(3 downto 0),
                LED2(3 downto 0)=>XLXN_10(3 downto 0),
                LED3(3 downto 0)=>XLXN_10(3 downto 0),
                LED4(3 downto 0)=>XLXN_10(3 downto 0),
                LED5(3 downto 0)=>XLXN_10(3 downto 0),
                LED6(3 downto 0)=>XLXN_10(3 downto 0),
                LED7(3 downto 0)=>XLXN_10(3 downto 0),
                LED8(3 downto 0)=>XLXN_10(3 downto 0),
                RESET=>RESET,
                DigitSelect(2 downto 0)=>DIGIT(2 downto 0),
                LEDOut(7 downto 0)=>LED(7 downto 0),
                light=>open);
   
   XLXI_3 : key44
      port map (row(3 downto 0)=>ROW(3 downto 0),
                rst=>RESET,
                sys_clk=>XLXN_2,
                code(3 downto 0)=>XLXN_10(3 downto 0),
                col(3 downto 0)=>COL(3 downto 0),
                valid=>open);
   
end BEHAVIORAL;


