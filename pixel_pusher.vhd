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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher is
  Port ( 
       clk, nbl, vs, vid : in  std_logic;
       pixel             : in  std_logic_vector (7 downto 0);
       hcount            : in  std_logic_vector (9 downto 0);
       r, b              : out std_logic_vector (4 downto 0);
       g                 : out std_logic_vector (5 downto 0);
       adder             : out std_logic_vector (17 downto 0)
  );
end pixel_pusher;

architecture Behavioral of pixel_pusher is

signal add : std_logic_vector(17 downto 0) := (others => '0');

begin
   process(clk) 
    begin
        if rising_edge(clk) then
            if nbl = '1' then 
                if unsigned(hcount) < 480 then
                    add <= std_logic_vector(unsigned(add) + 1);
                    r   <= pixel(7 downto 5) & "00";
                    g   <= pixel(4 downto 2) & "000";
                    b   <= pixel(1 downto 0) & "000";
                else
                    r <= (others => '0');
                    g <= (others => '0');
                    b <= (others => '0');
                end if;
            end if;
        end if;
   end process;
   
adder <= add;

end Behavioral;