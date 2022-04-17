LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY R1 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65536;
      read_address:   IN   integer RANGE 0 to 65536;
      we:    IN   std_logic;
      control_Reg1: in std_logic_vector(2 downto 0);
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

signal pc, RF_d1, RF_d2, ls_out, seB, t2, t1,IR,aluB,MemD,aluC: std_logic_vector(15 downto 0);
begin
rx1 : process( write_address, read_address, we, q, controlword_Reg1 )
begin
if (controlword_Reg1="001") then
   we <= "0";
   IR(11 downto 9) <= std_logic_vector(to_unsigned(read_address, 16));
   q <= aluB;
elsif (controlword_Reg1="010") then
   we <= "1";
   data <= MemD;
   IR(11 downto 9) <= std_logic_vector(to_unsigned(write_address, 16));
elsif (controlword_Reg1="011") then
   we <= "0";
   IR(11 downto 9) <= std_logic_vector(to_unsigned(read_address, 16));
   q <= t2;
elsif (controlword_Reg1="100") then
   we <= "1";
   data <= aluC;
   IR(11 downto 9) <= std_logic_vector(to_unsigned(write_address, 16)); 
end if;
END rtl;



ENTITY R2 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65536;
      read_address:   IN   integer RANGE 0 to 65536;
      we:    IN   std_logic;
      control_Reg2: in std_logic_vector(2 downto 0);
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

signal pc, RF_d1, RF_d2, ls_out, seB, t2, t1,IR,aluB,MemD,aluC: std_logic_vector(15 downto 0);
begin
rx2 : process( write_address, read_address, we, q, controlword_Reg2 )
begin         
if (controlword_Reg2="001") then
   we <= "0";
   IR(8 downto 6) <= std_logic_vector(to_unsigned(read_address, 16));
   q <= aluA;
elsif (controlword_Reg2="010") then
   we <= "0";
   IR(8 downto 6) <= std_logic_vector(to_unsigned(read_address, 16));
   q <= aluB;
elsif (controlword_Reg2="011") then
   we <= "0";
   IR(11 downto 9) <= std_logic_vector(to_unsigned(read_address, 16));
   q <= MemD;
elsif (controlword_Reg2="100") then
   we <= "1";
   data <= MemD;
   t1(2 downto 0) <= std_logic_vector(to_unsigned(write_address, 16)); 
elsif (controlword_Reg2="101") then
   we <= "0";
   t1(2 downto 0) <= std_logic_vector(to_unsigned(read_address, 16));
   q <= aluA;
elsif (controlword_Reg2="110") then
   we <= "1";
   data <= pc;
   IR(8 downto 6) <= std_logic_vector(to_unsigned(write_address, 16));
end if;
END rt2;

ENTITY R3 IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65536;
      read_address:   IN   integer RANGE 0 to 65536;
      we:    IN   std_logic;
      control_Reg3: in std_logic_vector(1 downto 0);
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

signal pc, RF_d1, RF_d2, ls_out, seB, t2, t1,IR,aluB,MemD,aluC: std_logic_vector(15 downto 0);
begin
rx3 : process( write_address, read_address, we, q, controlword_Reg3 )
begin
if (controlword_Reg3="01") then
   we <= "1";
   data <= aluC;
   IR(5 downto 3) <=  std_logic_vector(to_unsigned(write_address, 16));
elsif (controlword_Reg3="10") then
   we <= "1";
   data <= aluC;
   IR(8 downto 6) <= std_logic_vector(to_unsigned(write_address, 16));
elsif (controlword_Reg3="11") then
   we <= "1";
   data <= seB;
   IR(11 downto 9) <= std_logic_vector(to_unsigned(write_address, 16));
end if;  
END rtl;
