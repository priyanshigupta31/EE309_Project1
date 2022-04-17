-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  Full-adder.
library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
entity DUT is
   port(input_vector: in std_logic_vector(52 downto 0);
       	output_vector: out std_logic_vector(15 downto 0));
end entity;


architecture DutWrap of DUT is
   component R1 is
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
	end component;
begin
   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: R1
			port map (
					-- order of inputs
					clock => input_vector(52),
					data => input_vector(51 downto 36),
					write_address => to_integer(signed(input_vector(35 downto 20))),
					read_address => to_integer(signed(input_vector(19 downto 4))),
					we => input_vector(3),
					controlword_Reg1 => input_vector(2 downto 0),
					
					
               -- order of outputs
					q => output_vector(15 downto 0)
					);
end DutWrap;