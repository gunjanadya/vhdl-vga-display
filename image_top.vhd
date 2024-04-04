----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2024 09:05:34 PM
-- Design Name: 
-- Module Name: image_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
  Port ( 
      clk            : in  std_logic;
      vga_r, vga_b   : out std_logic_vector (4 downto 0);
      vga_g          : out std_logic_vector (5 downto 0);
      vga_vs, vga_hs : out std_logic
  );
end image_top;

architecture Behavioral of image_top is

component clock_div is
    port (
      clk : in  std_logic;
      div : out std_logic
    );
end component;

component picture is
  PORT (
    clka  : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

component pixel_pusher is
  Port ( 
       clk, nbl, vs, vid : in  std_logic;
       pixel             : in  std_logic_vector (7 downto 0);
       hcount            : in  std_logic_vector (9 downto 0);
       r, b              : out std_logic_vector (4 downto 0);
       g                 : out std_logic_vector (5 downto 0);
       adder             : out std_logic_vector (17 downto 0)
  );
end component;

component vga_ctrl is
  Port ( 
      clk, nbl       : in   std_logic;
      vid, hs, vs    : out  std_logic;
      hcount, vcount : out  std_logic_vector(9 downto 0)
  );
end component;

signal nbl, vid, vs   : std_logic                      := '0';
signal pixel          : std_logic_vector (7 downto 0)  := (others => '0');
signal hcount, vcount : std_logic_vector (9 downto 0)  := (others => '0');
signal adder          : std_logic_vector (17 downto 0) := (others => '0');

begin

U1: clock_div 
    port map (
        clk => clk,
        div => nbl
    );

U2: picture
    port map(
        clka  => clk,
        addra => adder,
        douta => pixel
    );
  
 U3: pixel_pusher
     port map(
        clk    => clk, 
        nbl    => nbl, 
        vs     => vs, 
        vid    => vid,
        pixel  => pixel,             
        hcount => hcount,           
        r      => vga_r, 
        b      => vga_b,             
        g      => vga_g,               
        adder  => adder            
     );

U4: vga_ctrl
    port map (
        clk    => clk,
        nbl    => nbl,
        vid    => vid,
        hs     => vga_hs,
        vs     => vs,
        hcount => hcount,
        vcount => vcount
    );
    
vga_vs <= vs;
end Behavioral;
