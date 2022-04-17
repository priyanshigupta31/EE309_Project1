library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity next_state_logic is
	port(IR : in std_logic_vector(15 DOWNTO 0);
		C : in std_logic;
	     	Z : in std_logic;
		reset : in std_logic;
		clock : in std_logic;
		currentstate : inout std_logic_vector(4 DOWNTO 0);
		nextstate : inout std_logic_vector(4 DOWNTO 0));
end next_state_logic;

architecture awesome of next_state_logic is	
	
	type state_type is (init, s0, s_ar, s_ar_ls, s_adi, s_lhi, s_ls, s_l, s_s, s_lm0, s_lm1, s_lm2, s_lm3, s_sm3, s_beq0, s_beq1, s0_b, s_jal1, s_jlr, s_jr1, s_jri2);
	signal state_present, state_next: state_type;
	
	clock_proc:process(clock,reset)
	begin
    	if(reset='1') then
        	state_present<=init;
    	elsif(clock='1' and clock' event) then
        	state_present<=state_next;
    	end if;
    	end process;
		
	next_state_logic: process (clock, reset, IR, C, Z)
	begin		
			case state_present is 
				when s0 =>
					if IR(15 downto 12) = "0001" and IR(1 downto 0) = "00" then						--ADD
						state_next <= s_ar;								
	
					elsif IR(15 downto 12) = "0001" and IR(1 downto 0) = "10" then					--ADC
						if C <= "1" then
							state_next <= s_ar;
						else
							state_next <= init;
						end if;
	
					elsif IR(15 downto 12) = "0001" and IR(1 downto 0) = "11" then					--ADL
						state_next <= s_ar_ls;
	
					elsif IR(15 downto 12) = "0001" and IR(1 downto 0) = "11" then					--ADZ
						if Z <= "1" then
							state_next <= s_ar;
						else
							state_next <= init;
						end if;
		
					elsif IR(15 downto 12) = "0000" then													--ADI
						state_next <= s_adi;
		
					elsif IR(15 downto 12) = "0010" and IR(1 downto 0) = "00" then					--NDU
						state_next <= s_ar;
		
					elsif IR(15 downto 12) = "0010" and IR(1 downto 0) = "10" then					--NDC
						if C <= "1" then
							state_next <= s_ar;
						else
							state_next <= init;
						end if;
	
					elsif IR(15 downto 12) = "0010" and IR(1 downto 0) = "01" then					--NDZ
						if Z <= "1" then
							state_next <= s_ar;
						else
							state_next <= init;
						end if;
	
					elsif IR(15 downto 12) = "1111" then													--LHI
						state_next <= s_lhi;
		
					elsif IR(15 downto 12) = "0111" or "0101" then										--LW and SW
						state_next <= s_ls;
						
					elsif IR(15 downto 12) = "1100" or "1101" then										--LM and SM
						state_next <= s_lm0;
					
					elsif IR(15 downto 12) = "1000" then													--BEQ
						state_next <= init;
					end if;
						
				when s_ar =>
					state_next <= init;
					
				when s_ar_ls =>
					state_next <= init;
					
				when s_adi =>
					state_next <= init;
					
				when s_lhi =>
					state_next <= init;
					
				when s_ls =>
					if IR(15 downto 12) = "0111" then
						state_next <= s_l;
					else
						state_next <= s_s;
					end if;
					
				when s_l =>
					state_next <= init;
					
				when s_s =>
					state_next <= init;
							
				when s_lm0 =>
					if t1 = 0 then
						state_next <= init;
					else
						state_next <= s_lm1;
					end if;
				
				when s_lm1 =>
					state_next <= s_lm2;
							
				when s_lm2 =>
					if t3(8) = '0' then
						state_next <= s_lm1;
					else
						if IR(15 downto 12) = "1100" then
							state_next <= s_lm3;
						else
							state_next <= s_sm3;
						end if;
					end if;
						
				when s_lm3 =>
					state_next <= s_lm4;
				
				when s_sm3 =>
					state_next <= s_lm4;
						
				when s_lm4 =>
					state_next <= s_lm1;
					
				when s_beq0 =>
					if t1 = '0' then
						state_next <= s_beq1;
					else
						state_next <= s0;
					end if;
					
				when s_beq1 =>
					state_next <= init;
					
				when s0_b =>
					if IR(15 downto 12) = "1001" then					--JAl
						state_next <= s_beq1;	
					else
						state_next <= s_jlr;
					end if;
					
				when s_jal1 =>
					state_next <= init;
					
				when s_jlr =>
					state_next <= init;
					
				when s_jr1 =>
					state_next <= s_jri2;
					
				when s_jri2 =>
					state_next <= init;
			
	      		end case;			
	end process;      
end awesome;
