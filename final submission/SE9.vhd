library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE9 is
port (
    IP : in std_logic_vector (8 downto 0);
    OP : out std_logic_vector (15 downto 0)
  );
end entity SE9;

architecture SignedExtender_arch of SE9 is
begin
  OP(8 downto 0) <= IP;
  process(ip)
  begin
  if ip(8) = '0' then
	OP(15 downto 9) <= (others=>'0');
  else
	OP(15 downto 9) <= (others=>'1');
end if;
end process;
end SignedExtender_arch;
