LIBRARY std;
USE std.standard.all;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity decoder_1_ns is
	port(X:in std_logic_vector(7 downto 0);
	Z: out std_logic_vector( 4 downto 0));
	end entity;

	architecture Behave of decoder_1_ns is
	begin
	process(X)
	variable NEXT_STATE_VAR: std_logic_vector(4 downto 0);
	begin

	if (X(7 downto 4) = "0001" or X(7 downto 4)="0010") then        --------1
		if(X(3 downto 2) = "00") then
			NEXT_STATE_VAR := "00011";
		elsif (X(3 downto 2) = "01") then
			if(X(0) = '1') then
				NEXT_STATE_VAR := "00011";
			else
				NEXT_STATE_VAR:= "00001";
			end if;
		elsif(X(3 downto 2) = "10") then
			if(X(1) = '1') then
				NEXT_STATE_VAR := "00011";
			else
				NEXT_STATE_VAR:= "00001";
			end if;
		else
			NEXT_STATE_VAR:="11111";
		end if;
	elsif (X(7 downto 4) = "0000" or X(7 downto 4) = "0101" or X(7 downto 4) = "0111" ) then   ---------123
		NEXT_STATE_VAR := "00011";
	elsif (X(7 downto 4) = "1101" or X(7 downto 4) = "1100") then -------------1,2
		NEXT_STATE_VAR := "00110";
	elsif (X(7 downto 4) = "0011") then
		NEXT_STATE_VAR := "00100";
	elsif (X(7 downto 4) = "1000") then     -------------
		NEXT_STATE_VAR := "01111";
	elsif (X(7 downto 4) = "1001" or X(7 downto 4) = "1010") then  --------
		NEXT_STATE_VAR := "10001";		
	else
		NEXT_STATE_VAR:="11111";
	end if;

	Z <= NEXT_STATE_VAR;
	end process;
end architecture Behave;
-------------------------------------


library std;
use std.STANDARD.all;

library ieee;
use ieee.STD_LOGIC_1164.all;

entity decoder_6_ns is
	port(X:in std_logic_vector(15 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end entity;

architecture Behave of decoder_6_ns is
	begin
	process(X)
	variable NEXT_STATE_VAR: std_logic_vector(4 downto 0);
	begin

	if(X = "0000000000000000" ) then
		NEXT_STATE_VAR:= "00001";
	else
		NEXT_STATE_VAR:= "01100";
	end if;

	Z<= NEXT_STATE_VAR;
	end process;
end architecture Behave;
-----------------------------------------

library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity decoder_5_ns is
	port(X:in std_logic_vector(15 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end entity;

architecture Behave of decoder_5_ns is
	begin
	process(X)
	variable NEXT_STATE_VAR: std_logic_vector(4 downto 0);
	begin

	if(X = "0000000000000000" ) then
		NEXT_STATE_VAR:= "00001";
	else
		NEXT_STATE_VAR:= "01010";
	end if;

	Z<= NEXT_STATE_VAR;
	end process;
end architecture Behave;
------------------------------

LIBRARY STD;
USE STD.STANDARD.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity decoder_3_ns is
	port(X:in std_logic_vector(3 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end entity;

architecture Behave of decoder_3_ns is
	begin
	process(X)
	variable NEXT_STATE_VAR: std_logic_vector(4 downto 0);
	begin

	if(X = "1101" ) then            ----------------
		NEXT_STATE_VAR:= "01010";
	elsif(X = "1100") then              ------------
		NEXT_STATE_VAR:="01100";
	elsif(X = "0011") then
		NEXT_STATE_VAR:="00100";
	else
		NEXT_STATE_VAR:="11111";
	end if;

	Z<= NEXT_STATE_VAR;
	end process;
end architecture Behave;
-------------------------------------
LIBRARY STD;
USE STD.STANDARD.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity decoder_4_ns is
	port(X:in std_logic_vector(3 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end entity;

architecture Behave of decoder_4_ns is
	begin
	process(X)
	variable NEXT_STATE_VAR: std_logic_vector(4 downto 0);
	begin

	if(X = "1001" ) then        ------
		NEXT_STATE_VAR:= "10010";
	elsif(X = "1010") then
		NEXT_STATE_VAR:="10011";
	else
		NEXT_STATE_VAR:="11111";
	end if;

	Z<= NEXT_STATE_VAR;
	end process;
end architecture Behave;
--------------------------------------


LIBRARY STD;
USE STD.STANDARD.ALL;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity decoder_2_ns is
	port(X:in std_logic_vector(3 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end entity;

architecture Behave of decoder_2_ns is
	begin
	process(X)
	variable NEXT_STATE_VAR: std_logic_vector(4 downto 0);
	begin

	if(X = "0000" or X="0010" or X="0001") then         ------------------
		NEXT_STATE_VAR:= "00100";
	elsif(X = "0101") then              -----------
		NEXT_STATE_VAR:="00111";
	elsif(X = "0111") then              ------------
		NEXT_STATE_VAR:="01001";
	else
		NEXT_STATE_VAR:="11111";
	end if;

	Z<= NEXT_STATE_VAR;
	end process;
end architecture Behave;
-------------------------------------
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity Next_state is 
	port( x : in std_logic_vector(39 downto 0); z : out std_logic_vector(4 downto 0));
end entity;

architecture Behave of Next_state is

component decoder_1_ns is
	port(X:in std_logic_vector(7 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end component;

component decoder_2_ns is
	port(X:in std_logic_vector(3 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end component;

component decoder_3_ns is
	port(X:in std_logic_vector(3 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end component;

component decoder_4_ns is
	port(X:in std_logic_vector(3 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end component;

component decoder_5_ns is
	port(X:in std_logic_vector(15 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end component;

component decoder_6_ns is
	port(X:in std_logic_vector(15 downto 0);
	Z: out std_logic_vector( 4 downto 0));
end component;

signal SIG1,SIG2,SIG3,SIG4,SIG5,SIG6: std_logic_vector(4 downto 0);

begin
-------------------------------------
a: decoder_1_ns port map(X(7 downto 4)=>x(39 downto 36),X(3 downto 2)=>x(25 downto 24),X(1 downto 0)=>x(23 downto 22),Z=>SIG1);
b: decoder_2_ns port map (X(3 downto 0)=>x(39 downto 36),Z=>SIG2);
c: decoder_3_ns port map (X(3 downto 0)=>x(39 downto 36),Z=>SIG3);
d: decoder_4_ns port map (X(3 downto 0)=>x(39 downto 36),Z=>SIG4);
e: decoder_5_ns port map (X(15 downto 0)=>x(21 downto 6),Z=>SIG5);
f: decoder_6_ns port map (X(15 downto 0)=>x(21 downto 6),Z=>SIG6);
--------------------------------------

process(x,SIG1,SIG2,SIG3,SIG4,SIG5,SIG6)
begin
if(x(4 downto 0) = "00001") then
	z<="00010";
elsif (x(4 downto 0) = "00010") then
	z<=SIG1;
elsif (x(4 downto 0) = "00011") then
	z<=SIG2;
elsif (x(4 downto 0) = "00100") then
	z<="00001";
elsif (x(4 downto 0) = "00110" )then
	z<=SIG3;	
elsif (x(4 downto 0) = "00111") then
	z<="01000";
elsif (x(4 downto 0) = "01000") then
	z<="00001";	
elsif (x(4 downto 0) = "01001") then
	z<="00001";		
elsif (x(4 downto 0) = "01010") then
	z<="01011";	
elsif (x(4 downto 0) = "01011") then
	z<=SIG5;
elsif (x(4 downto 0) = "01100") then
	z<="01101";	
elsif (x(4 downto 0) = "01101") then
	z<="01110";	
elsif (x(4 downto 0) = "01110") then
	z<=SIG6;
elsif (x(4 downto 0) = "01111") then
	z<="10000";	
elsif (x(4 downto 0) = "10000") then
	z<="00001";		
elsif (x(4 downto 0) = "10001") then
	z<=SIG4;
elsif (x(4 downto 0) = "10010") then
	z<="00001";	
elsif (x(4 downto 0) = "10011") then
	z<="00001";	
else
	z<="11111";
end if;

end process;

end Behave;							