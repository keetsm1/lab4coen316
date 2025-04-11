library IEEE;
use IEEE.std_logic_1164.all;

entity sign_extender is
	port(
		imm_in: in std_logic_vector(15 downto 0);
		ext_func: in std_logic_vector(1 downto 0);
		imm_out: out std_logic_vector(31 downto 0)
	);
end sign_extender;

architecture beh of sign_extender is 
begin
	process(imm_in, ext_func)
	begin
		case ext_func is
			when "00"=>
				imm_out<= imm_in & x"0000";--Lui
			when "01"=>
				imm_out<= (15 downto 0=> imm_in(15)) & imm_in;--sign extender
			when others=>
				imm_out<= (31 downto 16=> '0') & imm_in; --logical zero
		end case;
	end process;
end beh;
