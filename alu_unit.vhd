library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu_unit is 
port(
	x,y: in std_logic_vector(31 downto 0);
	add_sub: in std_logic;
	logic_func: in std_logic_vector(1 downto 0);
	func: in std_logic_vector(1 downto 0);
	output: out std_logic_vector(31 downto 0);
	overflow: out std_logic;
	zero: out std_logic);
end alu_unit;

architecture beh of alu_unit is 
signal addsub_out, logic_out: std_logic_vector(31 downto 0);
begin
   process(x,y,add_sub)
       begin
	if (add_sub= '0') then
	   addsub_out<= x+y;
	else
	  addsub_out<= x-y;
	end if;
   end process;
 

   process(x,y,logic_func)
      begin
	if(logic_func = "00") then
	 logic_out<= x and y;
	elsif(logic_func= "01") then
	 logic_out<= x or y;
	elsif (logic_func= "10") then 
	 logic_out<= x NOR y;
	else
	 logic_out<= x XOR y;
	end if;
      end process;

   process(x,y,func) 
      begin
	case func is
	 when "00"=>
	   output <= y;
	 when "01"=>
  	   output<="0000000000000000000000000000000" & addsub_out(31); 
	when "10"=>
     	   output<= addsub_out;
	when others=>
	    output<= logic_out;
	end case;
    end process;

   process(add_sub, addsub_out)
     begin
	if (addsub_out= "00000000000000000000000000000000") then
		zero<= '1';
	else
	   zero<= '0';
	end if;
   end process;
--overflow
process(x, y, add_sub, addsub_out)
    begin
        if (add_sub = '0') then
            if (x(31) = '0' and y(31) = '0' and addsub_out(31) = '1') or
               (x(31) = '1' and y(31) = '1' and addsub_out(31) = '0') then
                overflow <= '1';
            else
                overflow <= '0';
            end if;
        else
            if (x(31) = '0' and y(31) = '1' and addsub_out(31) = '1') or
               (x(31) = '1' and y(31) = '0' and addsub_out(31) = '0') then
                overflow <= '1';
            else
                overflow <= '0';
            end if;
        end if;
    end process;
end beh;


	
