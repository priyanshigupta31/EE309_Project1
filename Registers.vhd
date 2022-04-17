LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY R1 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 7;
      read_address:   IN   integer RANGE 0 to 7;
      we:    IN   std_logic;
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END R1;
ARCHITECTURE rtl OF R2 IS
   TYPE reg IS ARRAY(0 TO 7) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL reg_block : reg;
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (we = '1') THEN
            reg_block(write_address) <= data;
         END IF;
         q <= reg_block(read_address);
      END IF;
   END PROCESS;
         
if (controlword_Reg1="001") then
   we <= "0";
   read_address <= IR(11 downto 9);
   q <= aluB;
elsif (controlword_Reg1="010") then
   we <= "1";
   data <= MemD;
   write_address <= IR(11 downto 9);
elsif (controlword_Reg1="011") then
   we <= "0";
   read_address <= IR(11 downto 9);
   q <= t2;
elsif (controlword_Reg1="100") then
   we <= "1";
   data <= aluC;
   write_address <= IR(11 downto 9); 
end if;
END rtl;



ENTITY R2 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 7;
      read_address:   IN   integer RANGE 0 to 7;
      we:    IN   std_logic;
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END R2;
ARCHITECTURE rt2 OF R2 IS
   TYPE reg IS ARRAY(0 TO 7) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL reg_block : reg;
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (we = '1') THEN
            reg_block(write_address) <= data;
         END IF;
         q <= reg_block(read_address);
      END IF;
   END PROCESS;
         
if (controlword_Reg2="001") then
   we <= "0";
   read_address <= IR(8 downto 6);
   q <= aluA;
elsif (controlword_Reg2="010") then
   we <= "0";
   read_address <= IR(8 downto 6);
   q <= aluB;
elsif (controlword_Reg2="011") then
   we <= "0";
   read_address <= IR(11 downto 9);
   q <= MemD;
elsif (controlword_Reg2="100") then
   we <= "1";
   data <= MemD;
   write_address <= t1(2 downto 0); 
elsif (controlword_Reg2="101") then
   we <= "0";
   read_address <= t1(2 downto 0);
   q <= aluA;
elsif (controlword_Reg2="110") then
   we <= "1";
   data <= pc;
   write_address <= IR(8 downto 6);
end if;
END rt2;

ENTITY R3 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 7;
      read_address:   IN   integer RANGE 0 to 7;
      we:    IN   std_logic;
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END R3;
ARCHITECTURE rt3 OF R3 IS
   TYPE reg IS ARRAY(0 TO 7) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL reg_block : reg;
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (we = '1') THEN
            reg_block(write_address) <= data;
         END IF;
         q <= reg_block(read_address);
      END IF;
   END PROCESS;
         
if (controlword_Reg3="01") then
   we <= "1";
   data <= aluC;
   write_address <= IR(5 downto 3);
elsif (controlword_Reg3="10") then
   we <= "1";
   data <= aluC;
   write_address <= IR(8 downto 6);
elsif (controlword_Reg3="11") then
   we <= "1";
   data <= seB;
   write_address <= IR(11 downto 9);
end if;  
END rtl;
