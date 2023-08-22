library ieee;
use ieee.std_logic_1164.all;

entity T2 is
  port (EN, CLK: in std_logic;
        D, CLR: in std_logic_vector(15 downto 0);
        Q: out std_logic_vector(15 downto 0));
end entity;

architecture T2_arch of T2 is

component FF_WITH_CLEAR is
  port (D, CLEAR, EN, CLK: in std_logic; Q: out std_logic);

end component;

begin
S15: FF_WITH_CLEAR port map(D => D(15), CLEAR=>CLR(15), EN=>EN, Q=>Q(15), CLK=> CLK);
S14: FF_WITH_CLEAR port map(D => D(14), CLEAR=>CLR(14), EN=>EN, Q=>Q(14), CLK=> CLK);
S13: FF_WITH_CLEAR port map(D => D(13), CLEAR=>CLR(13), EN=>EN, Q=>Q(13), CLK=> CLK);
S12: FF_WITH_CLEAR port map(D => D(12), CLEAR=>CLR(12), EN=>EN, Q=>Q(12), CLK=> CLK);
S11: FF_WITH_CLEAR port map(D => D(11), CLEAR=>CLR(11), EN=>EN, Q=>Q(11), CLK=> CLK);
S10: FF_WITH_CLEAR port map(D => D(10), CLEAR=>CLR(10), EN=>EN, Q=>Q(10), CLK=> CLK);
S09: FF_WITH_CLEAR port map(D => D(09), CLEAR=>CLR(09), EN=>EN, Q=>Q(09), CLK=> CLK);
S08: FF_WITH_CLEAR port map(D => D(08), CLEAR=>CLR(08), EN=>EN, Q=>Q(08), CLK=> CLK);
S07: FF_WITH_CLEAR port map(D => D(07), CLEAR=>CLR(07), EN=>EN, Q=>Q(07), CLK=> CLK);
S06: FF_WITH_CLEAR port map(D => D(06), CLEAR=>CLR(06), EN=>EN, Q=>Q(06), CLK=> CLK);
S05: FF_WITH_CLEAR port map(D => D(05), CLEAR=>CLR(05), EN=>EN, Q=>Q(05), CLK=> CLK);
S04: ff_with_clear port map(D => D(04), CLEAR=>CLR(04), EN=>EN, Q=>Q(04), CLK=> CLK);
S03: FF_WITH_CLEAR port map(D => D(03), CLEAR=>CLR(03), EN=>EN, Q=>Q(03), CLK=> CLK);
S02: FF_WITH_CLEAR port map(D => D(02), CLEAR=>CLR(02), EN=>EN, Q=>Q(02), CLK=> CLK);
S01: FF_WITH_CLEAR port map(D => D(01), CLEAR=>CLR(01), EN=>EN, Q=>Q(01), CLK=> CLK);
S00: FF_WITH_CLEAR port map(D => D(00), CLEAR=>CLR(00), EN=>EN, Q=>Q(00), CLK=> CLK);
end T2_arch;
