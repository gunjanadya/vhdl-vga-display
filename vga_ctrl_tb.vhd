----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2024 02:57:05 PM
-- Design Name: 
-- Module Name: vga_ctrl_tb - Behavioral
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

entity vga_ctrl_tb is
--  Port ( );
end vga_ctrl_tb;

architecture Behavioral of vga_ctrl_tb is

component vga_ctrl 
  Port ( 
      clk, nbl       : in  std_logic;
      vid, hs, vs    : out std_logic;
      hcount, vcount : out  std_logic_vector(9 downto 0)
  );
end component;

signal clk, nbl, vid, hs, vs : std_logic        := '0';
signal hcount, vcount        : std_logic_vector(9 downto 0) := (others => '0');

begin
dut: vga_ctrl port map ( 
      clk,
      nbl,
      vid, 
      hs, 
      vs,
      hcount, 
      vcount
  );
    -- clock process @125 MHz
    process begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process;

    -- en process @ 125 MHz / 1085 = ~115200 Hz
    process begin
        nbl <= '0';
        wait for 8680 ns;
        nbl <= '1';
        wait for 8 ns;
    end process;

end Behavioral;
