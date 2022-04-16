    entity controloutput is
        port(ir: in std_logic_vector (15 downto 0);
            controlword: out std_logic_vector (5 downto 0);
            y_next: out std_logic_vector(4 downto 0))
    end controloutput;   
    
    architecture arch of controloutput is
        signal y_present: std_logic_vector (4 downto 0);
    begin
        if y_present = S0 then
           controlword = 0001;
        elsif y_present = S_ar then
            controlword = 0010;
        elsif y_present = S_ar_ls then
            controlword = 0011;
        elsif y_present = S_adi then
            controlword = 0100;
        elsif y_present = S_ls then
            controlword = 0101;
        elsif y_present = S_beq0 then
            controlword = 0110;
        elsif y_present = S_beq1 then
            controlword = 1001;
        elsif y_present = S_0b then
            controlword = 0111;
        elsif y_present = S_jri1 then
            controlword = 1000;
        elsif y_present = S_jri2 then
            controlword = 1010;
        else controlword = 0000;
        


            