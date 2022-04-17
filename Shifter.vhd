library ieee;
use ieee.std_logic_1164.all;

entity shifter is
    generic(
        operand_width : integer:=16
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end shifter;

architecture a1 of shifter is
    signal B: std_logic;
 
begin
shifter : process( A )
begin
   
	B <= A(15);
	for i in range 15 loop
		A(i+1) <= A(i);
	end loop
	A(0) <= B
	
end process;
		
if (controlword_Ls="01") then
	A <= RF_d2;
	B <= aluB;
if (controlword_Ls="10") then
	A <= IR;
	B <= t3;
end a1 ; -- a1
