library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_encoder is
-- Generic (CLK_BITS : INTEGER := 11)
port (
    IP : in std_logic_vector (7 downto 0);
    OP_ADDR : out std_logic_vector (2 downto 0);
    UPDATE : out std_logic_vector (7 downto 0)
  );
end entity priority_encoder;

architecture priority_encoder_arch of priority_encoder is
begin
process(IP)
	begin
  if IP(7) = '1' then
    OP_ADDR <= "111";
    UPDATE <= "00000000";
  elsif IP(6) = '1' then
    OP_ADDR <= "110";
    UPDATE(7) <= IP(7);
    UPDATE(6 downto 0) <= "0000000";
  elsif IP(5) = '1' then
    OP_ADDR <= "101";
    UPDATE(7 downto 6) <= IP(7 downto 6);
    UPDATE(5 downto 0) <= "000000";
  elsif IP(4) = '1' then
    OP_ADDR <= "100";
    UPDATE(7 downto 5) <= IP(7 downto 5);
    UPDATE(4 downto 0) <= "00000";
  elsif IP(3) = '1' then
    OP_ADDR <= "011";
    UPDATE(7 downto 4) <= IP(7 downto 4);
    UPDATE(3 downto 0) <= "0000";
  elsif IP(2) = '1' then
    OP_ADDR <= "010";
    UPDATE(7 downto 3) <= IP(7 downto 3);
    UPDATE(2 downto 0) <= "000";
  elsif IP(1) = '1' then
    OP_ADDR <= "001";
    UPDATE(7 downto 2) <= IP(7 downto  2);
    UPDATE(1 downto 0) <= "00";
  elsif IP(0) = '1' then
    OP_ADDR <= "000";
    UPDATE(7 downto 1) <= IP(7 downto 1);
    UPDATE(0) <= '0';
  else
	 OP_ADDR <= (others => '0');
	 UPDATE <= (others => '0');
  end if;
end process;
end priority_encoder_arch;
