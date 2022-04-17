LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ram_infer IS
   PORT
   (
      clock: IN   std_logic;
      data:  IN   std_logic_vector (15 DOWNTO 0);
      write_address:  IN   integer RANGE 0 to 65535;
      read_address:   IN   integer RANGE 0 to 65535;
      we:    IN   std_logic;
      control_m: in std_logic_vector(1 downto 0);
      q:     OUT  std_logic_vector (15 DOWNTO 0)
   );
END ram_infer;
ARCHITECTURE rtl OF ram_infer IS
   TYPE mem IS ARRAY(0 TO 65535) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL ram_block : mem;
	signal pc, ir, t1, RF_d1, RF_d2, t2 : std_logic_vector(15 downto 0);
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (we = '1') THEN
            ram_block(write_address) <= data;
         END IF;
         q <= ram_block(read_address);
      END IF;
   END PROCESS;


    mem_proc : process( data, write_address, read_address, we, control_m )
    begin
        if (control_m = "00") then --S0
            pc <= std_logic_vector(to_unsigned(read_address, 16));
            --we <= '0';
            q <= ir;--define
        elsif (control_m = "01") then --S_l
            t1 <= std_logic_vector(to_unsigned(read_address, 16));
            --we <= '0';
            q <= RF_d1;--define
        elsif (control_m = "10") then --S_s
            RF_d2 <= data;
            t2 <= std_logic_vector(to_unsigned(read_address, 16));
            --we <= '1';
        elsif (control_m = "11") then --S_lm3
            t2 <= std_logic_vector(to_unsigned(read_address, 16));
            --we <= '0';
            q <= RF_d2;--define
        end if;
    end process;



END rtl;
