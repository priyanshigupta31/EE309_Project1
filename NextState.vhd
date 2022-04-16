when s0  =>
	memA <= pc;
	 alu0: alu_beh
         port map (A => pc, B => "0000000000000010", sel => "00", op => t1, C => C);
	IR <= memD;
	
	
	
when s_ar =>
	RF_a1 <= IR (11 downto 9);
	RF_a2 <= IR (8 downto 6);
	alu1: alu_beh
         port map (A => RF_d1, B => RF_d2	, sel => IR(13 downto 12), op => RF_d3, C => C);
	RF_a3 <= IR(5 downto 3);
	
	
	
when s_ar_ls =>
	RF_a1 <= IR (11 downto 9);
	RF_a2 <= IR (8 downto 6);
	alu1: alu_beh
         port map (A => RF_d1, B => shifter(RF_d2)	, sel => IR(1 downto 0), op => RF_d3, C => C);
	RF_a3 <= IR(5 downto 3);
	
	
	
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
						state <= s_jal1;	
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