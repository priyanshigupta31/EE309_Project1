LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY R3 IS
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
END R3;
ARCHITECTURE rt3 OF R3 IS
   TYPE reg IS ARRAY(0 TO 7) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL reg_block : reg;
	signal pc, RF_d1, RF_d2, ls_out, seB, t2, t1,IR,aluB,MemD,aluC, aluA: std_logic_vector(15 downto 0);
	
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (we = '1') THEN
            reg_block(write_address) <= data;
         END IF;
         --q <= reg_block(read_address);
      END IF;
   END PROCESS;


rx3 : process( write_address, read_address, we, controlword_Reg3 )
begin
if (controlword_Reg3="01") then
   --we <= "1";
   aluC <= data;
   IR(5 downto 3) <=  std_logic_vector(to_unsigned(write_address, 3));
elsif (controlword_Reg3="10") then
   --we <= "1";
   aluC <= data;
   IR(8 downto 6) <= std_logic_vector(to_unsigned(write_address, 3));
elsif (controlword_Reg3="11") then
   --we <= "1";
   seB <= data;
   IR(11 downto 9) <= std_logic_vector(to_unsigned(write_address, 3));
end if;
end process;
END rt3;




