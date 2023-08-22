library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
  port(CLK: in std_logic;
      MEM_WRITE_BAR: in std_logic;
      ADDRESS: in std_logic_vector(15 downto 0);
      DATA_IN: in std_logic_vector(15 downto 0);
      DATA_OUT: out std_logic_vector(15 downto 0));
end entity;

architecture mem of memory is
  type RAM_array is array (0 to 2**4-1) of std_logic_vector (15 downto 0);
	signal RAM : RAM_array:= (X"3115",X"32C7",X"0050",X"039A",others=>X"0000");
begin
  process(CLK, MEM_WRITE_BAR, DATA_IN, ADDRESS, RAM)
    begin
    if rising_edge(CLK) then
      if(MEM_WRITE_BAR = '0') then
        RAM(to_integer(unsigned(address)))<= DATA_IN;
      end if;
    end if;
      DATA_OUT <= RAM(to_integer(unsigned(address)));
  end process;
end architecture mem;
