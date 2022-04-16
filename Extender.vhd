library ieee;
use ieee.std_logic_1164.all;

entity extender_8to16 is
    generic(
        operand_width : integer:=16
        );
    port (
        A: in std_logic_vector(7 downto 0);
        B: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end extender_8to16;


entity extender_9to16 is
    generic(
        operand_width : integer:=16
        );
    port (
        A: in std_logic_vector(8 downto 0);
		  sel: in std_logic;
        B: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end extender_9to16;


entity extender_6to16 is
    generic(
        operand_width : integer:=16
        );
    port (
        A: in std_logic_vector(5 downto 0);
        B: out std_logic_vector(operand_width-1 downto 0)
    ) ;
end extender_6to16;

architecture a1 of extender_8to16 is
    
begin
shift8to16 : process( A, B )
begin
			B <= "00000000"&A;
		
end process ; -- shift8to16
end a1 ; -- a1


architecture a2 of extender_9to16 is
    
begin
shift9to16 : process( A, B, sel )
begin
		if (sel = "0") then 
			B <= "0000000"&A;						--Zero at MSB
		else 
			B <= A&"0000000";						--Zero at LSB
		end if;
		
end process ; -- shift9to16
end a1 ; -- a1


architecture a3 of extender_6to16 is
    
begin
shift6to16 : process( A, B )
begin
			B <= "0000000000"&A;
		
end process ; -- shift6to16
end a3 ; -- a1
