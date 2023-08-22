LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity flip_flop is
  port (D, EN, RESET, CLK: in std_logic;
  Q: out std_logic);
end entity;

architecture FLIPFLOP of flip_flop is
begin

   process(CLK, EN, D)
   begin

  if CLK'event and (CLK = '1') then
    if RESET = '1' then
      Q <= '0';
    elsif(EN='1') then
        Q <= D;
    end if;
	 end if;
   end process;

end FLIPFLOP;
