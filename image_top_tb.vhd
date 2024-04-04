----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 01:40:22 AM
-- Design Name: 
-- Module Name: image_top_tb - Behavioral
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

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture Behavioral of image_top_tb is

component image_top is
  Port ( 
      clk            : in  std_logic;
      vga_r, vga_b   : out std_logic_vector (4 downto 0);
      vga_g          : out std_logic_vector (5 downto 0);
      vga_vs, vga_hs : out std_logic
  );
 end component;

signal clk, vga_vs, vga_hs : std_logic                     := '0';
signal vga_r, vga_b        : std_logic_vector (4 downto 0) := (others => '0');
signal vga_g               : std_logic_vector (5 downto 0) := (others => '0');

begin

    -- clock process @125 MHz
    process begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process;
    
    dut: image_top port map(
        clk,
        vga_r,
        vga_b,
        vga_g,
        vga_vs, 
        vga_hs
    );

end Behavioral;
