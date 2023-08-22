library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity control_signal is
	port(X: in std_logic_vector(26 downto 0);
	ALU_OP: out std_logic_vector(1 downto 0);
	ALU_A_MUX: out std_logic_vector( 1 downto 0);
	ALU_B_MUX: out std_logic_vector( 2 downto 0);
	RF_EN: out std_logic;
	R7_WR_MUX: out std_logic_vector( 1 downto 0);
	RF_A1_MUX: out std_logic_vector( 1 downto 0);
	RF_A3_MUX: out std_logic_vector( 2 downto 0);
	RF_D3_MUX: out std_logic_vector( 1 downto 0);
	MEM_WRITE_BAR: out std_logic;
	MEM_A_MUX: out std_logic_vector( 1 downto 0);
	MEM_D_MUX: out std_logic;
	EN_T1: out std_logic;
	EN_T2: out std_logic;
	EN_T3: out std_logic;
	EN_T4: out std_logic;
	PC_EN: out std_logic;
	IR_EN: out std_logic;
	TEMP_Z_EN: out std_logic;
	FLAGC_EN:out std_logic;
	FLAGZ_EN: out std_logic;
	T1_MUX: out std_logic_vector(1 downto 0);
	T2_MUX: out std_logic_vector(1 downto 0);
	T3_MUX: out std_logic;
	PC_MUX: out std_logic_vector(2 downto 0));
end entity;

architecture Bleh of control_signal is
begin
process(X)
begin
if(X(22 downto 18)="00001") then
    ALU_OP<="00";
	ALU_A_MUX<="00";
	ALU_B_MUX<="001";
	RF_EN<='0';
	R7_WR_MUX<="00";
	RF_A1_MUX<= "00";
	RF_A3_MUX<= "000";
	RF_D3_MUX<= "00";
	MEM_WRITE_BAR<='1';
	MEM_A_MUX<="00";
	MEM_D_MUX<='1';
	EN_T1<= '0';
	EN_T2<= '0';
	EN_T3<= '0';
	EN_T4<= '0';
	PC_EN<= '1';
	IR_EN<= '1';
	FLAGC_EN<='0';
	FLAGZ_EN<= '0';
	T1_MUX<= "00";
	T2_MUX<= "00";
	T3_MUX<='0';
	PC_MUX<= "000";
	TEMP_Z_EN<='1';
---------------------------------------------------------------------------------- State 
elsif(X(22 downto 18)="00100") then
	TEMP_Z_EN<='1';
	ALU_OP<="00";
	ALU_A_MUX<="10";
	ALU_B_MUX<="100";
	MEM_WRITE_BAR<='1';
	MEM_A_MUX<="00";
	MEM_D_MUX<='1';
	EN_T1<= '0';
	EN_T2<= '0';
	EN_T3<= '0';
	EN_T4<= '0';
	IR_EN<= '0';
	FLAGC_EN<='0';
	FLAGZ_EN<= '0';
	T1_MUX<= "00";
	T2_MUX<= "01";
	T3_MUX<='0';

	if (X(17 downto 14) = "0001" or X(17 downto 14) = "0010") then
		RF_EN<='1';
		RF_A1_MUX<= "00";
		RF_A3_MUX<= "001";
		RF_D3_MUX<= "00";
		PC_MUX<= "010";
		if(X(7 downto 5)="111") then
		R7_WR_MUX<="00";
		else
		R7_WR_MUX<="01";
		end if;
		if(X(7 downto 5) = "111") then
		PC_EN<= '1';
		else
		PC_EN<= '0';
		end if;
	elsif(X(17 downto 14)="0000") then          -------adi
		RF_EN<='1';
		RF_A1_MUX<= "00";
		RF_A3_MUX<= "011";
		RF_D3_MUX<= "00";
		PC_MUX<= "010";
		if(X(10 downto 8)="111") then
		R7_WR_MUX<="00";
		else
		R7_WR_MUX<="01";
		end if;
		if(X(10 downto 8) = "111") then
		PC_EN<= '1';
		else
		PC_EN<= '0';
		end if;
	elsif(X(17 downto 14)="0011") then
		RF_EN <='1';
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "100";
		RF_D3_MUX <= "01";
		PC_MUX <= "101";
		if(X(13 downto 11) = "111") then
		R7_WR_MUX <="00";
		else
		R7_WR_MUX <="01";
		end if;
		if(X(13 downto 11) = "111") then
		PC_EN <= '1';
		else
		PC_EN <= '0';
		end if;
	else
		RF_EN <='0';
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "100";
		RF_D3_MUX <= "01";
		PC_MUX <= "101";
		R7_WR_MUX <="00";
		PC_EN <= '0';
	end if;
--------------------------------------------------------------------------------------State 
elsif(X(22 downto 18)="00010") then
	TEMP_Z_EN<='1';
	ALU_OP<="00";
	ALU_A_MUX<="00";
	ALU_B_MUX<="001";
	R7_WR_MUX<="01";
	RF_A1_MUX<= "00";
	RF_A3_MUX<= "010";
	RF_D3_MUX<= "00";
	MEM_WRITE_BAR<='1';
	MEM_A_MUX<="00";
	MEM_D_MUX<='1';
	EN_T3<= '0';
	EN_T4<= '0';
	PC_EN<= '0';
	IR_EN<= '0';
	T3_MUX<='0';
	PC_MUX<= "000";
	EN_T1<= '1';
	EN_T2<= '1';
	FLAGC_EN<='0';
	FLAGZ_EN<= '0';
	T1_MUX<= "00";
	T2_MUX<= "00";
	if((X(17 downto 14)="0001" or X(17 downto 14)="0010" ) and X(3 downto 1)="100" ) then
		rf_en<='1';
	elsif((X(17 downto 14)="0001" or X(17 downto 14)="0010" ) and X(3 downto 2)="01" and X(0) = '0') then
		rf_en<='1';
	else
		rf_en<='0';
	end if;
-----------------------------------------------------------------State 
elsif(X(22 downto 18)="01010") then
		TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="10";
		ALU_B_MUX <="100";
		RF_EN <='0';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="01";
		MEM_D_MUX <='0';
		EN_T1 <= '0';
		EN_T2 <= '1';
		EN_T3 <= '1';
		EN_T4 <= '1';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "10";
		T2_MUX <= "11";
		T3_MUX <='0';
		PC_MUX <= "000";
------------------------------------------------------------------------------- State 
elsif(X(22 downto 18) = "00110") then
		TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="10";
		ALU_B_MUX <="100";
		RF_EN <='0';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="00";
		MEM_D_MUX <='1';
		EN_T1 <= '0';
		EN_T2 <= '1';
		EN_T3 <= '0';
		EN_T4 <= '0';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "00";
		T2_MUX <= "10";
		T3_MUX <='0';
		PC_MUX <= "000";
------------------------------------------------------------------------------- State 
elsif(X(22 downto 18) = "00111") then
		TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="10";
		ALU_B_MUX <="100";
		RF_EN <='0';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <= '1';
		MEM_A_MUX <= "01";
		MEM_D_MUX <= '1';
		EN_T1 <= '1';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "10";
		T2_MUX <= "10";
		T3_MUX <='0';
		PC_MUX <= "000";
-----------------------------------------------------------------State 
elsif(X(22 downto 18)="01001") then
		TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="10";
		ALU_B_MUX <="100";
		RF_EN <='1';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='0';
		MEM_A_MUX <="10";
		MEM_D_MUX <='0';
		EN_T1 <= '0';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "10";
		T2_MUX <= "10";
		T3_MUX <='0';
		PC_MUX <= "000";

---------------------------------------------------------------State 
elsif(X(22 downto 18) = "01011") then
		TEMP_Z_EN<='1';
		ALU_OP<="00";
		ALU_A_MUX<="01";
		ALU_B_MUX<="001";
		RF_EN<='1';
		if(X(25 downto 23)="111") then
		R7_WR_MUX<="00";
		else
		R7_WR_MUX<="01";
		end if;
		RF_A1_MUX<= "00";
		RF_A3_MUX<= "101";
		RF_D3_MUX<= "10";
		MEM_WRITE_BAR<='1';
		MEM_A_MUX<="01";
		MEM_D_MUX<='0';
		EN_T1<= '1';
		EN_T2<= '0';
		EN_T3<= '0';
		EN_T4<= '0';
		if(X(25 downto 23) = "111") then
		PC_EN<= '1';
		else
		PC_EN<='0';
		end if;
		IR_EN<= '0';
		FLAGC_EN<='0';
		FLAGZ_EN<= '0';
		T1_MUX<= "01";
		T2_MUX<= "11";
		T3_MUX<='0';
		PC_MUX<= "100";
-----------------------------------------------------------------State 
elsif(X(22 downto 18) =  "01100") then
		TEMP_Z_EN<='1';
		ALU_OP<="00";
		ALU_A_MUX<="10";
		ALU_B_MUX<="100";
		RF_EN<='0';
		R7_WR_MUX<="01";
		RF_A1_MUX<= "00";
		RF_A3_MUX<= "010";
		RF_D3_MUX<= "00";
		MEM_WRITE_BAR<='1';
		MEM_A_MUX<="01";
		MEM_D_MUX<='0';
		EN_T1<= '0';
		EN_T2<= '1';
		EN_T3<= '0';
		EN_T4<= '1';
		PC_EN<= '0';
		IR_EN<= '0';
		FLAGC_EN<='0';
		FLAGZ_EN<= '0';
		T1_MUX<= "10";
		T2_MUX<= "11";
		T3_MUX<='0';
		PC_MUX<= "000";
-----------------------------------------------------------------State 
elsif(X(22 downto 18) = "01101") then
	    TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="10";
		ALU_B_MUX <="100";
		RF_EN <='0';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "10";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="01";
		MEM_D_MUX <='0';
		EN_T1 <= '0';
		EN_T2 <= '0';
		EN_T3 <= '1';
		EN_T4 <= '0';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "10";
		T2_MUX <= "11";
		T3_MUX <='1';
		PC_MUX <= "000";
----------------------------------------------------------------State 
elsif(X(22 downto 18)="10000") then
		TEMP_Z_EN <='0';
		ALU_OP <="00";
		ALU_A_MUX <="01";
		ALU_B_MUX <="101";
		RF_EN <='1';
		if(X(26) = '0')then
		R7_WR_MUX <="01";
		PC_EN <= '0';
		else
		PC_EN <= '1';
		R7_WR_MUX <="11";
		end if;
		RF_A1_MUX <= "01";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <= '1';
		MEM_A_MUX <= "01";
		MEM_D_MUX <= '0';
		EN_T1 <= '0';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "00";
		T2_MUX <= "11";
		T3_MUX <='0';
		PC_MUX <= "000";
-------------------------------------------------------------------------------State 
elsif(X(22 downto 18) = "01000") then
		TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="01";
		ALU_B_MUX <="000";
		RF_EN <='1';
		if(X(13 downto 11)="111") then
		R7_WR_MUX <="00";
		else
		R7_WR_MUX <="01";
		end if;
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "100";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="00";
		mem_d_mux <='1';
		EN_T1 <= '0';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '1';
		T1_MUX <= "00";
		T2_MUX <= "01";
		T3_MUX <='0';
		PC_MUX <= "010";
		if(X(13 downto 11) = "111") then
		PC_EN <= '1';
		else
		PC_EN <= '0';
		end if;
-------------------------------------------------------------------------------------- State 
elsif(X(22 downto 18)="00011") then
	TEMP_Z_EN<='1';
	MEM_WRITE_BAR<='1';
	MEM_A_MUX<="00";
	MEM_D_MUX<='1';
	EN_T3<= '0';
	EN_T4<= '0';
	PC_EN<= '0';
	IR_EN<= '0';
	T3_MUX<='0';
	PC_MUX<= "000";
	RF_EN<='0';
	R7_WR_MUX<="01";
	RF_A1_MUX<= "00";
	RF_A3_MUX<= "010";
	RF_D3_MUX<= "00";
	if (X(17 downto 14) = "0001" or X(17 downto 14) = "0010") then
		ALU_A_MUX<="01";
		ALU_B_MUX<="010";
		EN_T1<= '1';
		EN_T2<= '0';
		T1_MUX<= "01";
		T2_MUX<= "00";
		if(X(17 downto 14) = "0001") then
			ALU_OP<="00";
		else
			ALU_OP<="10";
		end if;
		if(X(17 downto 14) = "0001") then
			FLAGC_EN<='1';
			FLAGZ_EN<= '1';
		else
			FLAGC_EN<='0';
			FLAGZ_EN<= '1';
		end if;
	elsif(X(17 downto 14) = "0001") then
		ALU_OP<="00";
		ALU_A_MUX<="01";
		ALU_B_MUX<="100";
		EN_T1<= '1';
		EN_T2<= '0';
		FLAGC_EN<='1';
		FLAGZ_EN<= '1';
		T1_MUX<= "01";
		T2_MUX<= "00";

	elsif(X(17 downto 14) = "0101") then ;;;;
		ALU_OP<="00";
		ALU_A_MUX<="10";
		ALU_B_MUX<="100";
		EN_T1<= '1';
		EN_T2<= '0';
		FLAGC_EN<='0';
		FLAGZ_EN<= '0';
		T1_MUX<= "01";
		T2_MUX<= "00";

	elsif(X(17 downto 14)="0111") then ;;;;;;
		ALU_OP<="00";
		ALU_A_MUX<="10";
		ALU_B_MUX<="100";
		EN_T1<= '0';
		EN_T2<= '1';
		FLAGC_EN<='0';
		FLAGZ_EN<= '0';
		T1_MUX<= "00";
		T2_MUX<= "01";

	else
		ALU_OP<="11";
		ALU_A_MUX<="10";
		ALU_B_MUX<="100";
		EN_T1<= '0';
		EN_T2<= '0';
		FLAGC_EN<='0';
		FLAGZ_EN<= '0';
		T1_MUX<= "00";
		T2_MUX<= "01";
	end if;

-----------------------------------------------------------------State 
elsif(X(22 downto 18)="01110") then
		TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="01";
		ALU_B_MUX <="001";
		RF_EN <='1';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "00";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='0';
		MEM_A_MUX <="01";
		MEM_D_MUX <='1';
		EN_T1 <= '1';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "01";
		T2_MUX <= "11";
		T3_MUX <='0';
		PC_MUX <= "000";
-----------------------------------------------------------------State 
elsif(X(22 downto 18)="01111") then
		TEMP_Z_EN <='1';
		ALU_OP <="01";
		ALU_A_MUX <="01";
		ALU_B_MUX <="010";
		RF_EN <='0';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "01";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="01";
		MEM_D_MUX <='0';
		EN_T1 <= '1';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "00";
		T2_MUX <= "11";
		T3_MUX <='0';
		PC_MUX <= "000";

--------------------------------------------------------------STate 
elsif(X(22 downto 18)="10001") then
	    TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="01";
		ALU_B_MUX <="001";
		RF_EN <='0';
		R7_WR_MUX <="01";
		RF_A1_MUX <= "01";
		RF_A3_MUX <= "010";
		RF_D3_MUX <= "00";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="01";
		MEM_D_MUX <='1';
		EN_T1 <= '0';
		EN_T2 <= '0';
		EN_T3 <= '1';
		EN_T4 <= '0';
		PC_EN <= '0';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "01";
		T2_MUX <= "11";
		T3_MUX <='1';
		PC_MUX <= "000";
--------------------------------------------------------------STate 
elsif(X(22 downto 18)="10010") then
	    TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="11";
		ALU_B_MUX <="011";
		RF_EN <='1';
		R7_WR_MUX <="11";
		RF_A1_MUX <= "01";
		RF_A3_MUX <= "100";
		RF_D3_MUX <= "10";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="01";
		MEM_D_MUX <='1';
		EN_T1 <= '0';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		PC_EN <= '1';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "01";
		T2_MUX <= "11";
		T3_MUX <='1';
		PC_MUX <= "000";
--------------------------------------------------------------STate 
elsif(X(22 downto 18)="10011") then
	    TEMP_Z_EN <='1';
		ALU_OP <="00";
		ALU_A_MUX <="11";
		ALU_B_MUX <="011";
		RF_EN <='1';
		R7_WR_MUX <="10";
		RF_A1_MUX <= "01";
		RF_A3_MUX <= "100";
		RF_D3_MUX <= "10";
		MEM_WRITE_BAR <='1';
		MEM_A_MUX <="01";
		MEM_D_MUX <='1';
		EN_T1 <= '0';
		EN_T2 <= '0';
		EN_T3 <= '0';
		EN_T4 <= '0';
		PC_EN <= '1';
		IR_EN <= '0';
		FLAGC_EN <='0';
		FLAGZ_EN <= '0';
		T1_MUX <= "01";
		T2_MUX <= "11";
		T3_MUX <='1';
		PC_MUX <= "011";
else
	TEMP_Z_EN <='1';
	ALU_OP <="00";
	ALU_A_MUX <="11";
	ALU_B_MUX <="011";
	RF_EN <='1';
	R7_WR_MUX <="10";
	RF_A1_MUX <= "01";
	RF_A3_MUX <= "100";
	RF_D3_MUX <= "10";
	MEM_WRITE_BAR <='1';
	MEM_A_MUX <="01";
	MEM_D_MUX <='1';
	EN_T1 <= '0';
	EN_T2 <= '0';
	EN_T3 <= '0';
	EN_T4 <= '0';
	PC_EN <= '0';
	IR_EN <= '0';
	FLAGC_EN <='0';
	FLAGZ_EN <= '0';
	T1_MUX <= "01";
	T2_MUX <= "11";
	T3_MUX <='1';
	PC_MUX <= "011";
end if;

end process;

end Bleh;
