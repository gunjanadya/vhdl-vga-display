----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2024 11:12:32 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
  Port ( 
      clk, nbl       : in  std_logic;
      vid, hs, vs    : out std_logic;
      hcount, vcount : out  std_logic_vector(9 downto 0)
  );
end vga_ctrl;

architecture Behavioral of vga_ctrl is

begin

    process(clk) 
    begin
        if rising_edge(clk) then
            if nbl = '1' and unsigned(hcount) < 800 then
                hcount <= std_logic_vector( unsigned(hcount) + 1);
            else
                hcount <= (others => '0');
                if unsigned(vcount) < 525 then
                    vcount <= std_logic_vector( unsigned(vcount) + 1);
                else
                    vcount <= (others => '0');
                end if;
            end if;
            if unsigned(hcount) < 640 and unsigned(vcount) < 480 then
                vid <= '1';
            else
                vid <= '0';
            end if;
            if unsigned(hcount) > 655 and unsigned(hcount) < 750 then
                hs <= '0';
            else
                hs <= '1';
            end if;
            if unsigned(vcount) > 489 and unsigned(vcount) < 492 then
                vs <= '0';
            else
                vs <= '1';
            end if;
        end if;
    end process;
    
end Behavioral;
