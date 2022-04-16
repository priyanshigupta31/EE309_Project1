library ieee;
use ieee.std_logic_1164.all;

entity alu_beh is
    generic(
        operand_width : integer:=16;
        sel_line : integer:=2
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: in std_logic_vector(operand_width-1 downto 0);
        sel: in std_logic_vector(sel_line-1 downto 0);
        op: out std_logic_vector(operand_width-1 downto 0);
		  C: out std_logic
    ) ;
end alu_beh;

architecture a1 of alu_beh is
    function add(A: in std_logic_vector(operand_width-1 downto 0); 
					  B: in std_logic_vector(operand_width-1 downto 0))
        return std_logic_vector is
            -- Declare "sum" and "carry" variable
            -- you can use aggregate to initialize the variables & signals as shown below
            --    variable variable_name : std_logic_vector(3 downto 0) := (others => '0');
				variable sum_int: std_logic_vector(operand_width-1 downto 0);
				variable carry: std_logic_vector(operand_width downto 0);
				variable sum: std_logic_vector(operand_width-1 downto 0);
        begin
            -- write logic for addition
            -- Hint: Use for loop
				carry(0) := '0';
				L1: for i in 0 to 3 loop
					sum_int(i) := A(i) xor B(i) xor carry(i);
					carry(i+1) := (A(i) and B(i)) or ((A(i) xor B(i)) and carry(i));
				end loop L1;
				C := carry(operand_width-1)
				sum := sum_int;
            return sum;
    end add;
	 
	 function nand_16(A: in std_logic_vector(operand_width-1 downto 0); 
					  B: in std_logic_vector(operand_width-1 downto 0))
        return std_logic_vector is
				variable result: std_logic_vector(operand_width-1 downto 0);
        begin
            -- write logic for addition
            -- Hint: Use for loop
				L1: for i in 0 to operand_width-1 loop
					result(i) := A(i) nand B(i);
				end loop L1;
            return result;
    end nand_16;
	 
	 function add_2(A: in std_logic_vector(operand_width-1 downto 0))
        return std_logic_vector is
				constant B: std_logic_vector(operand_width-1 downto 0)):="0000000000000011";
            variable sum_int: std_logic_vector(operand_width-1 downto 0);
				variable carry: std_logic_vector(operand_width downto 0);
				variable sum: std_logic_vector(operand_width-1 downto 0);
        begin
            -- write logic for addition
            -- Hint: Use for loop
				carry(0) := '0';
				L1: for i in 0 to 3 loop
					sum_int(i) := A(i) xor B(i) xor carry(i);
					carry(i+1) := (A(i) and B(i)) or ((A(i) xor B(i)) and carry(i));
				end loop L1;
				sum := sum_int;
            return sum;
    end add_2;
	 
	 function sub(A: in std_logic_vector(operand_width-1 downto 0); 
					  B: in std_logic_vector(operand_width-1 downto 0))
        return std_logic_vector is
            variable diff_int: std_logic_vector(operand_width-1 downto 0);
				variable carry: std_logic_vector(operand_width downto 0);
				variable diff: std_logic_vector(operand_width-1 downto 0);
				variable B_xor_M: std_logic_vector(operand_width-1 downto 0);
				constant M: std_logic:= '1';
        begin
            -- write logic for addition
            -- Hint: Use for loop
				carry(0) := '1';
				L1: for i in 0 to 3 loop
					B_xor_M(i) := B(i) xor M;
					diff_int(i) := A(i) xor B(i) xor carry(i);
					carry(i+1) := (A(i) and B(i)) or ((A(i) xor B(i)) and carry(i));
				end loop L1;
				C := carry(operand_width-1)
				diff := diff_int;
            return diff;
    end sub;

 
begin
alu : process( A, B, sel )
begin
   -- complete VHDL code for various outputs of ALU based on select lines
   -- Hint: use if/else statement
      if (sel = "00") then 
			op <= add_2(A);
		elsif (sel = "01") then
			op <= add(A, B);
		elsif (sel = "10") then
			op <= "nand_16(A, B);
		else 
			op <= sub(A, B);
		end if;
   -- add function usage :
   --   signal_name <= add(A,B)
   --   variable_name := add(A,B)
   --
   -- concatenate operator usage:
   --    "0000"&A 
end process ; -- alu
end a1 ; -- a1
