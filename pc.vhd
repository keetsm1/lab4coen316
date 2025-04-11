library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc is
port(
clk:in std_logic;
reset: in std_logic;
pc_in: in std_logic_vector(31 downto 0);
pc_out: out std_logic_vector(31 downto 0)
);
end pc;

architecture beh of pc is
begin
process(clk,reset)
begin
if (reset='1') then
pc_out<= (others=>'0');
elsif (clk'event and clk='1') then
pc_out<= pc_in;
end if;
end process;
end beh;
