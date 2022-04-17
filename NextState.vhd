
	
	
next_state_logic: process (clock, reset, IR, C, Z)
	type state_type is (init, s0, s_ar, s_ar_ls, s_adi, s_lhi, s_ls, s_l, s_s, s_lm0, s_lm1, s_lm2, s_lm3, s_sm3, s_beq0, s_beq1, s0_b, s_jal1, s_jlr, s_jr1, s_jri2);
	signal state; state_type
	begin
		if (reset = '1') then
			state <= init;
		elsif (clock 'event and clock = '1') then 
		
			case state is 
				when s0 =>
					if IR(15 downto 12) = "0001" and IR(1 downto 0) = "00" then						--ADD
						state <= s_ar;								
	
					elsif IR(15 downto 12) = "0001" and IR(1 downto 0) = "10" then					--ADC
						if C <= "1" then
							state <= s_ar;
						else
							state <= init;
						end if;
	
					elsif IR(15 downto 12) = "0001" and IR(1 downto 0) = "11" then					--ADL
						state <= s_ar_ls;
	
					elsif IR(15 downto 12) = "0001" and IR(1 downto 0) = "11" then					--ADZ
						if Z <= "1" then
							state <= s_ar;
						else
							state <= init;
						end if;
		
					elsif IR(15 downto 12) = "0000" then													--ADI
						state <= s_adi;
		
					elsif IR(15 downto 12) = "0010" and IR(1 downto 0) = "00" then					--NDU
						state <= s_ar;
		
					elsif IR(15 downto 12) = "0010" and IR(1 downto 0) = "10" then					--NDC
						if C <= "1" then
							state <= s_ar;
						else
							state <= init;
						end if;
	
					elsif IR(15 downto 12) = "0010" and IR(1 downto 0) = "01" then					--NDZ
						if Z <= "1" then
							state <= s_ar;
						else
							state <= init;
						end if;
	
					elsif IR(15 downto 12) = "1111" then													--LHI
						state <= s_lhi;
		
					elsif IR(15 downto 12) = "0111" or "0101" then										--LW and SW
						state <= s_ls;
						
					elsif IR(15 downto 12) = "1100" or "1101" then										--LM and SM
						state <= s_lm0;
					
					elsif IR(15 downto 12) = "1000" then													--BEQ
						state <= init;
					end if;
						
				when s_ar =>
					state <= init;
					
				when s_ar_ls =>
					state <= init;
					
				when s_adi =>
					state <= init;
					
				when s_lhi =>
					state <= init;
					
				when s_ls =>
					if IR(15 downto 12) = "0111" then
						state <= s_l;
					else
						state <= s_s;
					end if;
					
				when s_l =>
					state <= init;
					
				when s_s =>
					state <= init;
							
				when s_lm0 =>
					if t1 = 0 then
						state <= init;
					else
						state <= s_lm1;
					end if;
				
				when s_lm1 =>
					state <= s_lm2;
							
				when s_lm2 =>
					if t3(8) = '0' then
						state <= s_lm1;
					else
						if IR(15 downto 12) = "1100" then
							state <= s_lm3;
						else
							state <= s_sm3;
						end if;
					end if;
						
				when s_lm3 =>
					state <= s_lm4;
				
				when s_sm3 =>
					state <= s_lm4;
						
				when s_lm4 =>
					state <= s_lm1;
					
				when s_beq0 =>
					if t1 = '0' then
						state <= s_beq1;
					else
						state <= s0;
					end if;
					
				when s_beq1 =>
					state <= init;
					
				when s0_b =>
					if IR(15 downto 12) = "1001" then					--JAl
						state <= s_beq1;	
					else
						state <= s_jlr;
					end if;
					
				when s_jal1 =>
					state <= init;
					
				when s_jlr =>
					state <= init;
					
				when s_jr1 =>
					state <= s_jri2;
					
				when s_jri2 =>
					state <= init;
						
end process;
