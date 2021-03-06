library ieee;
use ieee.std_logic_1164.all;

entity shifter is
    generic(
        operand_width : integer:=16
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
		  controlword_Ls: in std_logic_vector(1 downto 0);
        B: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end shifter;

architecture a1 of shifter is
    signal C: std_logic;

signal pc, RF_d1, RF_d2, aluB, seB, t2, t1,t3, IR, A_temp: std_logic_vector(15 downto 0);
begin
shifter : process( A )
begin
   
	C <= A(15);
	for i in 0 to 14 loop
		A_temp(i+1) <= A(i);
		B(i+1) <= A_temp(i+1);
	end loop;
	B(0) <= C;
	
end process;


ls1 : process( A )
begin
		
if controlword_Ls="01" then
	--A <= RF_d2;
	B <= aluB;
	RF_d2 <= A;
	--aluB <= B;
end if;
if controlword_Ls="10" then
	--A <= IR;
	B <= t3;
	IR <= A;
	--t3 <= B;
end if;

end process;

end a1 ; -- a1
