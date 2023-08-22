library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity FSM is
	port(RESET,CLOCK: in std_logic;
	IR: in std_logic_vector(15 downto 0);
	CARRY_REG,ZERO_REG: in std_logic;
	T2: in std_logic_vector(15 downto 0);
	TEMP_Z: in std_logic;
	T4: in std_logic_vector(2 downto 0);
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

architecture Behave of FSM is

component control_signal is
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
end component;

component Next_state is 
	port( X : in std_logic_vector(39 downto 0); Z: out std_logic_vector(4 downto 0));
end component;

signal Q: std_logic_vector(4 downto 0);
signal NQ: std_logic_vector( 4 downto 0);

begin


NEXT_STATE_A: Next_state port map(X(39 downto 24)=>IR,X(23)=>CARRY_REG,X(22)=>ZERO_REG,X(21 DOWNTO 6)=>T2,X(5)=>TEMP_Z, X(4 DOWNTO 0)=>Q, Z=>NQ);
NEXT_STATE_B: control_signal port map(X(26)=>TEMP_Z,X(25 downto 23)=>T4,X(22 downto 18)=>Q,X(17 downto 2)=>IR, X(1)=>CARRY_REG,X(0)=>ZERO_REG,ALU_OP=>ALU_OP, ALU_A_MUX=>ALU_A_MUX, ALU_B_MUX=>ALU_B_MUX,RF_EN=>RF_EN,R7_WR_MUX=>R7_WR_MUX,RF_A1_MUX=>RF_A1_MUX,RF_A3_MUX=>RF_A3_MUX,RF_D3_MUX=>RF_D3_MUX,MEM_WRITE_BAR=>MEM_WRITE_BAR,MEM_A_MUX=>MEM_A_MUX,MEM_D_MUX=>MEM_D_MUX,EN_T1=>EN_T1,EN_T2=>EN_T2,EN_T3=>EN_T3,EN_T4=>EN_T4,PC_EN=>PC_EN,IR_EN=>IR_EN,TEMP_Z_EN=>TEMP_Z_EN,FLAGC_EN=>FLAGC_EN,FLAGZ_EN=>FLAGZ_EN,T1_MUX=>T1_MUX,T2_MUX=>T2_MUX,T3_MUX=>T3_MUX,PC_MUX=>PC_MUX);

process(NQ,CLOCK,RESET,Q)
begin
if(CLOCK'EVENT AND CLOCK='1') then
	if(RESET='1') then
		Q<="00001";
	else
	 	Q<=NQ;
	end if;
end if;
end process;
end Behave;
