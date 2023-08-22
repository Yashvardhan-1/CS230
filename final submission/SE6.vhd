library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE6 is
port (
    IP : in std_logic_vector (5 downto 0);
    OP : out std_logic_vector (15 downto 0)
  );
end entity SE6;

architecture SignedExtender_arch of SE6 is
begin
  OP(5 downto 0) <= IP;
  --op(15 downto 6) <= ip(5);
  process(IP)
  begin
  if IP(5) = '0' then
	OP(15 downto 6) <= (others=>'0');
  else
	OP(15 downto 6) <= (others=>'1');
end if;
end process;
end SignedExtender_arch;
