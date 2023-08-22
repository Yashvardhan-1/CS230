library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RegFile is
Generic (NUM_BITS : INTEGER := 16);
port (
    CLK ,RESET: in std_logic;
    RF_A1, RF_A2, RF_A3 : in std_logic_vector (2 downto 0);
    RF_D3 : in std_logic_vector(NUM_BITS - 1 downto 0);
    RF_D1, RF_D2 : out std_logic_vector(NUM_BITS - 1 downto 0);
    ALU_TO_R7, T2_TO_R7, PC_TO_R7 : in std_logic_vector (NUM_BITS - 1 downto 0);
   -- r7_op : out std_logic_vector (NUM_BITS - 1 downto 0);
    RF_WR: in std_logic;
    R7_WR_MUX : in std_logic_vector(1 downto 0)
  );
end entity RegFile;

architecture Register_file of RegFile is

--type reg_file is array(0 to 7) of std_logic_vector(NUM_BITS - 1 downto 0);
--signal rf : reg_file;

component reg is
Generic (NUM_BITS : INTEGER := 16);
  port (EN, RESET, CLK: in std_logic;
        IP: in std_logic_vector(NUM_BITS-1 downto 0);
        OP: out std_logic_vector(NUM_BITS-1 downto 0)
		  );
end component;


type rin is array(0 to 7) of std_logic_vector(NUM_BITS - 1 downto 0);
signal REG_IN,REG_OUT : rin;
--signal r_in: std_logic_vector(15 downto 0);
signal WR_ENABLE,WR_ENABLE_FINAL: std_logic_vector(7 downto 0);

begin

RF_D1 <= REG_OUT(to_integer(unsigned(rf_a1)));
RF_D2 <= REG_OUT(to_integer(unsigned(rf_a2)));

with RF_A3 select
 WR_ENABLE <= 	"10000001" when "000",
          "10000000" when "111",
					"10001000" when "011",
          "10000100" when "010",
					"10010000" when "100",
					"10100000" when "101",
					"11000000" when "110",
          "10000010" when "001",
					"00000000" when others;

  REG_IN(6) <= RF_D3;
  REG_IN(5) <= RF_D3;
  REG_IN(4) <= RF_D3;
  REG_IN(3) <= RF_D3;
  REG_IN(2) <= RF_D3;
  REG_IN(1) <= RF_D3;
  REG_IN(0) <= RF_D3;
with R7_WR_MUX select REG_IN(7) <=
        RF_D3 when "00",
        PC_TO_R7 when "01",
        T2_TO_R7 when "10",
        ALU_TO_R7 when "11",
		  (others => '0') when others;

WR_ENABLE_FINAL(7) <= WR_ENABLE(7) and RF_WR;
WR_ENABLE_FINAL(6) <= WR_ENABLE(6) and RF_WR;
WR_ENABLE_FINAL(5) <= WR_ENABLE(5) and RF_WR;
WR_ENABLE_FINAL(4) <= WR_ENABLE(4) and RF_WR;
WR_ENABLE_FINAL(3) <= WR_ENABLE(3) and RF_WR;
WR_ENABLE_FINAL(2) <= WR_ENABLE(2) and RF_WR;
WR_ENABLE_FINAL(1) <= WR_ENABLE(1) and RF_WR;
WR_ENABLE_FINAL(0) <= WR_ENABLE(0) and RF_WR; 

  R : for n in 0 to 7 generate
      Rn: reg port map(EN =>WR_ENABLE_FINAL(n),RESET => RESET,CLK => CLK,IP=>REG_IN(n),OP=>REG_OUT(n));
  end generate R;

end Register_file;
