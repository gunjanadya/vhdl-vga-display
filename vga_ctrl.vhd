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
      hcount, vcount : out std_logic_vector(9 downto 0)
  );
end vga_ctrl;

architecture Behavioral of vga_ctrl is

signal hc, vc : std_logic_vector (9 downto 0) := (others => '0');

begin

    process(clk) 
    begin
        if rising_edge(clk) then
            if nbl = '1' then 
                if unsigned (hc) >= 0 and unsigned(hc) < 799 then
                    hc <= std_logic_vector( unsigned(hc) + 1);
                else
                    hc <= (others => '0');
                    if unsigned(hc) >= 0 and unsigned(vc) < 524 then
                        vc <= std_logic_vector(unsigned(vc) + 1);
                    else
                        vc <= (others => '0');
                    end if;
                end if;
            end if;
            
        end if;
    end process;
    
    process(hc, vc)
    begin
    
        if unsigned(hc) >= 0 and unsigned(hc) <= 639 and unsigned(vc) >= 0 and unsigned(vc) <= 479 then
            vid <= '1';
        else
            vid <= '0';
        end if;
        
        if unsigned(hc) >= 656 and unsigned(hc) <= 751 then
            hs <= '0';
        else
            hs <= '1';
        end if;
        
        if unsigned(vc) >= 490 and unsigned(vc) <= 491 then
            vs <= '0';
        else
            vs <= '1';
        end if;
        
    end process;
    
    hcount <= hc;
    vcount <= vc;
end Behavioral;
