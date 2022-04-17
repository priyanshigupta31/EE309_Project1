    entity controloutput is
        port(ir: in std_logic_vector (15 downto 0);
            controlword_ALU: out std_logic_vector (3 downto 0);
            controlword_Mem: out std_logic_vector (2 downto 0);
            controlword_Reg1: out std_logic_vector (2 downto 0);
            controlword_Reg2: out std_logic_vector (2 downto 0);
            controlword_Reg3: out std_logic_vector (2 downto 0);
            controlword_Ls: out std_logic_vector (1 downto 0);
            controlword_SE1: out std_logic_vector (1 downto 0);
            controlword_SE2: out std_logic_vector (1 downto 0);
            controlword_pco: out std_logic_vector (2 downto 0);
            controlword_pci: out std_logic_vector (2 downto 0);
            controlword_t1o: out std_logic_vector (2 downto 0);
            controlword_t1i: out std_logic_vector (1 downto 0);
            controlword_t2o: out std_logic_vector (1 downto 0);
            controlword_t2i: out std_logic_vector (1 downto 0);
            controlword_t3o: out std_logic_vector (1 downto 0);
            controlword_t3i: out std_logic_vector (1 downto 0);
            controlword_t4o: out std_logic;
            controlword_t4i: out std_logic;
            --y_next: out std_logic_vector(4 downto 0))
    end controloutput;   
    
    architecture arch of controloutput is
        signal y_present: std_logic_vector (4 downto 0);
    begin
        if y_present = S0 then                      --1
            controlword_ALU = 0001;
            controlword_Mem = 001;
            controlword_Reg1 = 000;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 001;
            controlword_pci = 001;
            controlword_t1o = 001;
            controlword_t1i = 01;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;
             
        elsif y_present = S_ar then                 --2
            controlword_ALU = 0010;
            controlword_Mem = 000;
            controlword_Reg1 = 001;
            controlword_Reg2 = 001;
            controlword_Reg3 = 001;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;
        
        elsif y_present = S_ar_ls then              --3
            controlword_ALU = 0011;
            controlword_Mem = 000;
            controlword_Reg1 = 001;
            controlword_Reg2 = 010;
            controlword_Reg3 = 001;
            controlword_Ls = 001;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;
                
        elsif y_present = S_adi then                --4
            controlword_ALU = 0100;
            controlword_Mem = 000;
            controlword_Reg1 = 001;
            controlword_Reg2 = 000;
            controlword_Reg3 = 010;
            controlword_Ls = 000;
            controlword_SE1 = 01;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;
        
        elsif y_present = s_lhi then                --5
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Reg1 = 000;
            controlword_Reg2 = 000;
            controlword_Reg3 = 011;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 01;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_ls then                 --6
            controlword_ALU = 0101;
            controlword_Mem = 000;
            controlword_Reg1 = 000;
            controlword_Reg2 = 001;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 10;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 01;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = s_l then                  --7
            controlword_ALU = 0000;
            controlword_Mem = 010;
            controlword_Reg1 = 010;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 01;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;
        
        elsif y_present = s_s then                  --8
            controlword_ALU = 0000;
            controlword_Mem = 011;
            controlword_Reg1 = 000;
            controlword_Reg2 = 011;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 01;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;
        
        elsif y_present = s_lm0 then                --9
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Reg1 = 011;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 10;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = s_lm1 then                --10
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Reg1 = 000;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 010;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 01;
            controlword_t4o = 0;
            controlword_t4i = 0;
                
        elsif y_present = S_lm2 then                --11
            controlword_ALU = 1011;
            controlword_Mem = 000;
            controlword_Reg1 = 000;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 010;
            controlword_t1i = 10;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 01;
            controlword_t3i = 00;
            controlword_t4o = 1;
            controlword_t4i = 1;
        
        elsif y_present = s_lm3 then                --12
            controlword_ALU = 0000;
            controlword_Mem = 100;
            controlword_Reg1 = 000;
            controlword_Reg2 = 100;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 100;
            controlword_t1i = 00;
            controlword_t2o = 01;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_lm4 then                --13
            controlword_ALU = 1100;
            controlword_Mem = 000;   
            controlword_Reg1 = 000;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 10;
            controlword_t2i = 11;
            controlword_t3o = 10;
            controlword_t3i = 10;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = s_sm3 then                --14
            controlword_ALU = 0000;
            controlword_Mem = 011;
            controlword_Reg1 = 000;
            controlword_Reg2 = 101;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 101;
            controlword_t1i = 00;
            controlword_t2o = 01;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_beq0 then               --15          
            controlword_ALU = 0110;
            controlword_Mem = 000;
            controlword_Reg1 = 001;
            controlword_Reg2 = 001;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 01;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_beq1 then               --16
            controlword_ALU = 1001;
            controlword_Mem = 000;
            controlword_Reg1 = 000;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 01;
            controlword_SE2 = 00;
            controlword_pco = 010;
            controlword_pci = 010;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_0b then                 --17
            controlword_ALU = 0111;
            controlword_Mem = 001;
            controlword_Reg1 = 100;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 010;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_jlr then               --18
            controlword_ALU = 000;
            controlword_Mem = 000;
            controlword_Reg1 = 000;
            controlword_Reg2 = 110;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 10;
            controlword_pco = 000;
            controlword_pci = 011;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_jri1 then               --19
            controlword_ALU = 1000;
            controlword_Mem = 000;
            controlword_Reg1 = 001;
            controlword_Reg2 = 000;
            controlword_Reg3 = 000;
            controlword_Ls = 000;
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 000;
            controlword_t1o = 000;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

        elsif y_present = S_jri2 then               --20
            controlword_ALU = 1010;
            controlword_Mem = 000;
            controlword_Reg1 = 000;
            controlword_Reg2 = 000;
            controlword_Reg3 = 100;
            controlword_Ls = 000; 
            controlword_SE1 = 00;
            controlword_SE2 = 00;
            controlword_pco = 000;
            controlword_pci = 010;
            controlword_t1o = 011;
            controlword_t1i = 00;
            controlword_t2o = 00;
            controlword_t2i = 00;
            controlword_t3o = 00;
            controlword_t3i = 00;
            controlword_t4o = 0;
            controlword_t4i = 0;

  
        else controlword_ALU = 0000;
        

        

            
