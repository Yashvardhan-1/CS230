library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port(ALU_OP: in std_logic_vector(2 downto 1);
      ALU_A: in std_logic_vector(15 downto 0);
      ALU_B: in std_logic_vector(15 downto 0);
      ALU_C: out std_logic;
      ALU_Z: out std_logic;
      ALU_OUT: out std_logic_vector(15 downto 0));
end entity;

architecture ALU_arch of ALU is

begin

  process(ALU_OP, ALU_A, ALU_B)
  variable A_A, A_B : std_logic_vector(16 downto 0);
  variable A_O : std_logic_vector(16 downto 0);
  
	 begin
    
    A_A(15 downto 0) := ALU_A;
    A_A(16) := '0';
    A_B(15 downto 0) := ALU_B;
    A_B(16) := '0';

	 case (ALU_OP) is
		
		when "10" =>
			A_O(15 downto 0) := A_A(15 downto 0) nand A_B(15 downto 0);
			A_O(16) := '0';
    when "01" =>
			A_O(15 downto 0) := std_logic_vector(unsigned(A_A(15 downto 0)) - unsigned(A_B(15 downto 0)));
			A_O(16) := '0';
    when "00" =>
		  A_O := std_logic_vector(unsigned(A_A) + unsigned(A_B));
		when others =>
			A_O(16 downto 0) := (others=>'0');
    end case;

    ALU_Z <= not (A_O(15) or A_O(14) or A_O(13) or A_O(12) or A_O(11) or A_O(10) or A_O(9) or A_O(8) or A_O(7) or A_O(6) or A_O(5) or A_O(4) or A_O(3) or A_O(2) or A_O(1) or A_O(0));
    ALU_OUT <= A_O(15 downto 0);
    ALU_C <= A_O(16);
    
  end process;
end architecture ALU_arch;
