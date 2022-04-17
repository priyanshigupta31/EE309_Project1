library ieee;
use ieee.std_logic_1164.all;



entity extender_6to16 is
    generic(
        operand_width : integer:=16
        );
    port (
        A: in std_logic_vector(5 downto 0);
		  controlword_SE1: in std_logic_vector(1 downto 0);
        B: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end extender_6to16;


architecture a3 of extender_6to16 is
    signal pc, RF_d1, RF_d2, ls_out, seB, t2, t1, IR, aluB, aluA: std_logic_vector(15 downto 0);
begin
shift6to16 : process( A )
begin
			B <= "0000000000"&A;
		
end process ; -- shift6to16


ext2 : process( A )
begin
if (controlword_SE1="01") then
    IR(5 downto 0) <= A;
    B <= aluB;
	 
end if;
if (controlword_SE1="10") then
    IR(5 downto 0) <= A;
    B <= aluA;
	 
end if;
end process;

end a3 ; -- a1