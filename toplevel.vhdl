library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity toplevel is
   port(	clk: in std_logic;
			rst: in std_logic);
end entity;

architecture a of toplevel is
    component extender_9to16LSB is
        generic(
            operand_width : integer:=16
            );
        port (
            A: in std_logic_vector(8 downto 0);
              controlword_SE3: in std_logic;
            B: out std_logic_vector(operand_width-1 downto 0)
        ) ;
    end component;

    component extender_9to16MSB is
        generic(
            operand_width : integer:=16
            );
        port (
            A: in std_logic_vector(8 downto 0);
              controlword_SE2: in std_logic;
            B: out std_logic_vector(operand_width-1 downto 0)
        ) ;
    end component;

    component extender_6to16 is
        generic(
            operand_width : integer:=16
            );
        port (
            A: in std_logic_vector(5 downto 0);
              controlword_SE1: in std_logic_vector(1 downto 0);
            B: out std_logic_vector(operand_width-1 downto 0)
        ) ;
    end component;

    component next_state_logic is
        port(IR : in std_logic_vector(15 DOWNTO 0);
            C : in std_logic;
           Z : in std_logic;
            reset : in std_logic;
            clock : in std_logic;
            t1, t3 : in std_logic_vector(15 DOWNTO 0));
    end component;

    component shifter is
        generic(
            operand_width : integer:=16
            );
        port (
            A: in std_logic_vector(operand_width-1 downto 0);
              controlword_Ls: in std_logic_vector(1 downto 0);
            B: out std_logic_vector(operand_width-1 downto 0)
        ) ;
    end component;

    component controloutput is
        port(ir: in std_logic_vector (15 downto 0);
            controlword_ALU: out std_logic_vector (3 downto 0);
            controlword_Mem: out std_logic_vector (2 downto 0);
            controlword_Reg1: out std_logic_vector (2 downto 0);
            controlword_Reg2: out std_logic_vector (2 downto 0);
            controlword_Reg3: out std_logic_vector (1 downto 0);
            controlword_Ls: out std_logic_vector (1 downto 0);
            controlword_SE1: out std_logic_vector (1 downto 0);
            controlword_SE2: out std_logic;
            controlword_SE3: out std_logic;
            controlword_pco: out std_logic_vector (2 downto 0);
            controlword_pci: out std_logic_vector (2 downto 0);
    end component;   
    
    component alu_beh is
        generic(
            operand_width : integer:=16;
            sel_line : integer:=2
            );
        port (
            A: in std_logic_vector(operand_width-1 downto 0);
            B: in std_logic_vector(operand_width-1 downto 0);
            sel: in std_logic_vector(sel_line-1 downto 0);
            controlword_alu: in std_logic_vector(3 downto 0);
            op: out std_logic_vector(operand_width-1 downto 0);
              C: out std_logic
        ) ;
    end component;
    
    component ram_infer IS
        PORT(clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65535;
      read_address:   IN   integer RANGE 0 to 65535;
      we:    IN   std_logic;
      control_m: in std_logic_vector(1 downto 0);
      q:     OUT  std_logic_vector (15 DOWNTO 0)
     );
    END component;

    --registers
   component R1 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65536;
      read_address:   IN   integer RANGE 0 to 65536;
      we:    IN   std_logic;
      controlword_Reg1: in std_logic_vector(2 downto 0);
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END component;
	     
   component R2 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65536;
      read_address:   IN   integer RANGE 0 to 65536;
      we:    IN   std_logic;
      controlword_Reg2: in std_logic_vector(2 downto 0);
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END component;
	     
   component R3 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65536;
      read_address:   IN   integer RANGE 0 to 65536;
      we:    IN   std_logic;
      controlword_Reg3: in std_logic_vector(1 downto 0);
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END component;

    --signals
	type state_type is (init, s0, s_ar, s_ar_ls, s_adi, s_lhi, s_ls, s_l, s_s, s_lm0, s_lm1, s_lm2, s_lm3, s_lm4, s_sm3, s_beq0, s_beq1, s0_b, s_jal1, s_jlr, s_jr1, s_jri2);
	signal state_present, state_next: state_type;
	TYPE reg IS ARRAY(0 TO 7) OF std_logic_vector(15 DOWNTO 0);
	     
   	SIGNAL reg_block : reg;
	     
	signal: pc, RF_d1, RF_d2, ls_out, seB, t2, t1, IR, aluB, aluA, MemD, aluC, A_temp, t3, t4, data: std_logic_vector(15 downto 0);
	     
	signal y_present: std_logic_vector(4 downto 0);
	     
	     
	signal C, S, clock, reset, we: std_logic;
	     
	     
	signal: controlword_ALU: std_logic_vector(3 downto 0);
	signal: controlword_Mem, controlword_Reg1, controlword_Reg2, controlword_pco, controlword_pci: std_logic_vector(2 downto 0);
	signal: controlword_Reg3, controlword_Ls, controlword_SE1: std_logic_vector(1 downto 0);
	signal: controlword_SE2, controlword_SE3: std_logic;
	     
	     
	variable integer read_address, write_address;
    begin
        ex1: extender_6to16 port map (A => IR(5 downto 0), B => aluB, controlword_SE1 => controlword_SE1);			--aluA or aluB?
        ex2: extender_9to16LSB port map(A => IR(8 downto 0), B => aluB, controlword_SE3 => controlword_SE3);
        ex3: extender_9to16MSB port map(A => IR(8 downto 0), B => aluB, controlword_SE2 => controlword_SE2);

        nsl: next_state_logic port map(IR => IR, C => C, Z => Z, clock => clock, reset => reset, t1 => t1, t3 => t3);
	 
	rf1: R1 port map (clock => clock, data => data, write_address => write_address, read_address => read_address, we => we, controlword_Reg1 => controlword_Reg1);
	rf2: R2 port map (clock => clock, data => data, write_address => write_address, read_address => read_address, we => we, controlword_Reg1 => controlword_Reg2);
	rf3: R3 port map (clock => clock, data => data, write_address => write_address, read_address => read_address, we => we, controlword_Reg1 => controlword_Reg3);
	

        shift: shifter port map(A => IR, B => t3, controlword_Ls => controlword_Ls);

        alu1: alu port map(A => aluA, B => aluB, sel => sel, controlword_ALU => controlword_ALU ,op => aluC, C => C);

        mem: ram_infer port map(clock => clock, data => MemD, write_address => write_address, read_address => read_address, we => we, q => aluA, controlword_m => controlword_m);

        control: controloutput port map(
	    controlword_ALU => controlword_ALU,
            controlword_Mem => controlword_Mem,
            controlword_Reg1 => controlword_Reg1,
            controlword_Reg2 => controlword_Reg2,
            controlword_Reg3 => controlword_Reg3,
            controlword_Ls => controlword_Ls,
            controlword_SE1 => controlword_SE1,
            controlword_SE2 => controlword_SE2,
            controlword_SE3 => controlword_SE3,
            controlword_pco => controlword_pco,
            controlword_pci => controlword_pci
	);

        end a;



    
