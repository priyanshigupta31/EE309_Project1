library ieee;
use ieee.std_logic_1164.all;



entity extender_9to16LSB is
    generic(
        operand_width : integer:=16
        );
    port (
        A: in std_logic_vector(8 downto 0);
		  controlword_SE3: in std_logic;
        B: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end extender_9to16LSB;


architecture a3 of extender_9to16LSB is
    signal pc, RF_d1, RF_d2, ls_out, seB, t2, t1, IR, aluB, aluA: std_logic_vector(15 downto 0);
begin
shift6to16 : process( A )
begin
			B <= A&"0000000";
		
end process ; -- shift9to16


ext2 : process( A )
begin
if controlword_SE3='1' then
    IR(8 downto 0) <= A;
    B <= aluB;
	 
end if;

end process;

end a3 ; -- a1