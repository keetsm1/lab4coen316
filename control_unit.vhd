library IEEE;
use IEEE.std_logic_1164.all;

entity control_unit is
port(
opcode: in std_logic_vector(5 downto 0);
funct: in std_logic_vector(5 downto 0);
reg_write: out std_logic;
reg_dst: out std_logic;
reg_in_src: out std_logic;
alu_src: out std_logic;
add_sub: out std_logic;
data_write: out std_logic;
logic_func: out std_logic_vector(1 downto 0);
ext_func: out std_logic_vector(1 downto 0);
branch_type: out std_logic_vector(1 downto 0);
pc_sel: out std_logic_vector(1 downto 0)
);
end control_unit;

architecture beh of control_unit is
begin
process(opcode,funct)
begin
reg_write<= '0';
reg_dst<= '0';
reg_in_src<= '0';
alu_src <= '0';
add_sub<= '0';
data_write<= '0';
logic_func  <= "00";
ext_func<= "11";
branch_type<= "00";
pc_sel<= "00";

case opcode is
when "000000" =>
reg_write<= '1';
case funct is
when "100000" =>
add_sub<= '0'; --sub
when "101010" =>
add_sub<= '1'; --slt
when "100100" =>
logic_func<= "00";-- and
when "100101" =>
logic_func<= "01";-- or
when "100110"=>
logic_func<= "10";--xor
when "100111"=>
logic_func<= "11"; --nor
when "001000"=>
pc_sel <= "10"; --jr
when others=> null;
end case;
when "001111"=> --lui
reg_write<='1';
reg_dst<= '0';
alu_src<= '1';
reg_in_src<='1';
ext_func<= "00";
when "001000" => --addi
reg_write<='1';
reg_dst<= '0';
alu_src<= '1';
reg_in_src<='0';
add_sub<='0';
ext_func<= "01";
when "001010"=> --slti
reg_write<='1';
reg_dst<= '0';
alu_src<= '1';
reg_in_src<='0';
add_sub<='1';
ext_func<= "01";
when "001100" => --andi
reg_write<='1';
reg_dst<= '0';
alu_src<= '1';
reg_in_src<='0';
logic_func<="00";
ext_func<= "11";
when "001101"=>--ori
reg_write<='1';
reg_dst<= '0';
alu_src<= '1';
reg_in_src<='0';
logic_func<="01";
ext_func<= "11";
when "001110"=>--xori
reg_write<= '1';
reg_dst<= '0';
alu_src<= '1';
reg_in_src<='0';
logic_func<="10";
ext_func<= "11";
when "100011" =>--lw
reg_write<= '1';
reg_dst<= '0';
alu_src<='1';
reg_in_src<='1';
ext_func<="01";
when "101011"=> --sw
data_write<='1';
alu_src<= '1';
ext_func<= "01";
when "000100" => --beq
branch_type<= "01";
pc_sel<= "01";
when "000101"=> --bne
branch_type<= "10";
pc_sel<= "01";
when "000001"=> --bltz
branch_type<= "11";
pc_sel<= "01";
when "000010" => --j
pc_sel<="11";
when others => null;
end case;
end process;
end beh;
