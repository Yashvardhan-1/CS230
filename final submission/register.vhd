library ieee;
use ieee.std_logic_1164.all;

entity reg is
Generic (NUM_BITS : INTEGER := 16);
  port (EN, RESET, CLK: in std_logic;
        IP: in std_logic_vector(NUM_BITS-1 downto 0);
        OP: out std_logic_vector(NUM_BITS-1 downto 0)
		  );
end entity;

architecture reg_arch of reg is
begin
REG1 : process(CLK, EN, IP)
begin
  if CLK'event and CLK = '1' then
    if reset = '1' then
      OP(NUM_BITS-1 downto 0) <= (others=>'0');
    elsif EN = '1' then
      OP <= IP;
    end if;
  end if;
end process;

end reg_arch;
