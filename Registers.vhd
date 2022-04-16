LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY reg_infer IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 7;
      read_address:   IN   integer RANGE 0 to 7;
      we:    IN   std_logic;
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END reg_infer;
ARCHITECTURE rtl OF reg_infer IS
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
END rtl;