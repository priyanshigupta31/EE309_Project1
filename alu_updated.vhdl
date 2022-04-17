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
		control: in std_logic_vector(3 downto 0);
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
alu : process( A, B, sel, control )
begin
    
        if(control = "0001") then --S0
            A <= pc; --define pc signal?
            op <= add_2(A); -- not possible to use op, define t1?
           -- t1 <= op;
        
        elsif(control = "0010") then --S_ar
            A <= RF_d1;--define
            B <= RF_d2;--define
            if (sel = "00") then 
                op <= add_2(A);
            elsif (sel = "01") then
                op <= add(A, B);
            elsif (sel = "10") then
                op <= nand_16(A, B);
            else 
                op <= sub(A, B);
            end if;
           -- RF_d3 <= op;--define
        
        elsif(control = "0011") then --S_ar_ls
            A <= RF_d1;--define
            --ls_in <= RF_d2;--define, instantiate shifter
            B <= ls_out;
            if (sel = "00") then 
                op <= add_2(A);
            elsif (sel = "01") then
                op <= add(A, B);
            elsif (sel = "10") then
                op <= nand_16(A, B);
            else 
                op <= sub(A, B);
            end if;
           -- RF_d3 <= op;--define
        
        elsif(control = "0100") then --S_adi
            A <= RF_d1;
            B <= se16_out;--define
            op <= add(A, B);
            --RF_d3 <= op;
        
        elsif(control = "0101") then --S_ls
            A <= se16_out;--**
            B <= RF_d1;
            op <= add(A, B);
            --memA <= op;
        
        elsif (control = "0110") then --S_beq0
            A <= RF_d1;
            B <= RF_d2;
            op <= sub (A, B);
            --t1 <= op;
        
        elsif (control = "1001") then --S_beq1
            A <= pc;
            B <= se16_out;
            op <= sub (A, B);
            --t1 <= op;
        
        elsif (control = "0111") then --S_0b
            A <= pc;
            op <= add_2(A);
            --RF_d3 <= op;
        
        elsif (control = "1000") then --S_jri1
            A <= RF_d1;
            B <= se16_out;
            op <= add(A, B);
            --RF_d3 <= op;
        
        elsif (control = "1011") then --S_lm4
            A <= t2;
            op <= add_2(A);
            --t3 <= op;

        elsif (control = "1100") then --S_lm2
            A <= t1;
            B <= "0000000000000001";
            op <= sub(A, B);
            --t4 <= op;
        
        
    
    
end process ; -- alu
end a1 ; -- a1
