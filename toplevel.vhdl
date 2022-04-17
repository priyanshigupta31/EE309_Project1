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

    --signals

    begin
        ex1: extender_6to16 port map ();
        ex2: extender_9to16LSB port map();
        ex3: extender_9to16MSB port map();

        nsl: next_state_logic port map();

        shift: shifter port map();

        alu1: alu port map();

        mem: ram_infer port map();

        control: controloutput port map();

        




    
