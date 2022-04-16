    entity controloutput is
        port(ir: in std_logic_vector (15 downto 0);
            controlword_ALU: out std_logic_vector (3 downto 0);
            controlword_Mem: out std_logic_vector (2 downto 0);
            controlword_Reg: out std_logic_vector (3 downto 0);
            controlword_Ls: out std_logic_vector (1 downto 0);
            controlword_SE1: out std_logic_vector (1 downto 0);
            controlword_SE1: out std_logic_vector (1 downto 0);
            controlword_pco: out std_logic_vector (2 downto 0);
            controlword_pci: out std_logic_vector (2 downto 0);
             
            --y_next: out std_logic_vector(4 downto 0))
    end controloutput;   
    
    architecture arch of controloutput is
        signal y_present: std_logic_vector (4 downto 0);
    begin
        if y_present = S0 then                      --1
            controlword_ALU = 0001;
            controlword_Mem = 001;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 001;
            controlword_pci = 001;
             
        elsif y_present = S_ar then                 --2
            controlword_ALU = 0010;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;
        
        elsif y_present = S_ar_ls then              --3
            controlword_ALU = 0011;
            controlword_Mem = 000;
            controlword_Ls = 001;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;
                
        elsif y_present = S_adi then                --4
            controlword_ALU = 0100;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 001;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;
        
        elsif y_present = s_lhi then                --5
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 001;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = S_ls then                 --6
            controlword_ALU = 0101;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 010;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = s_l then                  --7
            controlword_ALU = 0000;
            controlword_Mem = 010;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;
        
        elsif y_present = s_s then                  --8
            controlword_ALU = 0000;
            controlword_Mem = 011;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;
        
        elsif y_present = s_lm0 then                --9
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = s_lm1 then                --10
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Ls = 010;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;
                
        elsif y_present = S_lm2 then                --11
            controlword_ALU = 1011;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;
        
        elsif y_present = s_lm3 then                --12
            controlword_ALU = 0000;
            controlword_Mem = 100;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = S_lm4 then                --13
            controlword_ALU = 1100;
            controlword_Mem = 000;    
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = s_sm3 then                --14
            controlword_ALU = 0000;
            controlword_Mem = 011;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = S_beq0 then               --15          
            controlword_ALU = 0110;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = S_beq1 then               --16
            controlword_ALU = 1001;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 001;
            controlword_SE2 = 000;
            controlword_pco = 010;
            controlword_pci = 010;

        elsif y_present = S_0b then                 --17
            controlword_ALU = 0111;
            controlword_Mem = 001;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 010;
            controlword_pci = 000;

        elsif y_present = S_jlr then               --18
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 010;
            controlword_pco = 000;
            controlword_pci = 011;

        elsif y_present = S_jri1 then               --19
            controlword_ALU = 1000;
            controlword_Mem = 000;
            controlword_Ls = 000;
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 000;

        elsif y_present = S_jri2 then               --20
            controlword_ALU = 1010;
            controlword_Mem = 000;
            controlword_Ls = 000; 
            controlword_SE1 = 000;
            controlword_SE2 = 000;
            controlword_pco = 000;
            controlword_pci = 010;

  
        else controlword_ALU = 0000;
        

        

            
