library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity next_address is
port(
    pc          : in std_logic_vector(31 downto 0);
    imm_ext     : in std_logic_vector(31 downto 0);
    instr       : in std_logic_vector(31 downto 0);
    zero        : in std_logic;
    branch_type : in std_logic_vector(1 downto 0);
    pc_sel      : in std_logic_vector(1 downto 0);
    pc_next     : out std_logic_vector(31 downto 0)
    );
end next_address;



architecture beh of next_address is
begin
	process(pc, imm_ext, instr, zero, branch_type, pc_sel)
	begin
		case pc_sel is
			when "00" =>
				pc_next <= std_logic_vector(unsigned(pc) + to_unsigned(1, 32)); 

			when "01" =>
				if (branch_type = "01" and zero = '1') or 
				   (branch_type = "10" and zero = '0') or 
				   (branch_type = "11" and imm_ext(31) = '1') then
					pc_next <= std_logic_vector(unsigned(pc) + to_unsigned(1, 32) + unsigned(imm_ext)); 
				else 
					pc_next <= std_logic_vector(unsigned(pc) + to_unsigned(1, 32));
				end if;

			when "10" =>
				pc_next <= instr; -- jr

			when "11" =>
				pc_next <= pc(31 downto 28) & instr(25 downto 0) & "00"; -- j

			when others =>
				pc_next <= pc;
		end case;
	end process;
end beh;

