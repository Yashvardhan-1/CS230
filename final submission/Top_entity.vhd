library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity Top_entity is
	port(RESET,CLOCK:in std_logic);
end entity;

architecture BEHAVE of Top_entity is

component FSM is
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

end component;

component datapath is
Generic (NUM_BITS : INTEGER := 16);
  port(
  CLK,RESET: in std_logic;
    ALU_OPR: in std_logic_vector(1 downto 0);
	ALU_A_MUX: in std_logic_vector( 1 downto 0);
	ALU_B_MUX: in std_logic_vector( 2 downto 0);
	RF_EN: in std_logic;
	R7_WR_MUX: in std_logic_vector( 1 downto 0);
	RF_A1_MUX: in std_logic_vector( 1 downto 0);
	RF_A3_MUX: in std_logic_vector( 2 downto 0);
	RF_D3_MUX: in std_logic_vector( 1 downto 0);
	MEM_WRITE_BAR: in std_logic;
	MEM_A_MUX: in std_logic_vector( 1 downto 0);
	MEM_D_MUX: in std_logic;
	EN_T1, EN_T2, EN_T3, EN_T4 : in std_logic;
	PC_EN: in std_logic;
	IR_EN: in std_logic;
	FLAGC_EN:in std_logic;
	FLAGZ_EN: in std_logic;
	T1_MUX: in std_logic_vector(1 downto 0);
	T2_MUX: in std_logic_vector(1 downto 0);
	T3_MUX: in std_logic;
	PC_MUX: in std_logic_vector(2 downto 0);
	TEMP_Z_EN: in std_logic;
	FLAGC, flagz: out std_logic;
	T4_OUT: out std_logic_vector(2 downto 0);
	T2_OUT: out std_logic_vector(15 downto 0);
	IR_OUT: out std_logic_vector(15 downto 0);
	TEMPZ: out std_logic
  );
  end component;
signal IR_SIG: std_logic_vector(15 downto 0);
signal	CARRY_REG_SIG,Zero_reg_sig: std_logic;
signal	T2_SIG: std_logic_vector(15 downto 0);
signal	TEMP_Z_SIG: std_logic;
signal	T4_SIG: std_logic_vector(2 downto 0);
signal	ALU_OP_SIG: std_logic_vector(1 downto 0);
signal	ALU_A_MUX_SIG: std_logic_vector( 1 downto 0);
signal	ALU_B_MUX_SIG: std_logic_vector( 2 downto 0);
signal	RF_EN_SIG: std_logic;
signal	R7_WR_MUX_SIG: std_logic_vector( 1 downto 0);
signal	RF_A1_MUX_SIG: std_logic_vector( 1 downto 0);
signal	RF_A3_MUX_SIG: std_logic_vector( 2 downto 0);
signal	RF_D3_MUX_SIG: std_logic_vector( 1 downto 0);
signal	MEM_WRITE_BAR_SIG: std_logic;
signal	MEM_A_MUX_SIG: std_logic_vector( 1 downto 0);
signal	MEM_D_MUX_SIG: std_logic;
signal	EN_T1_SIG: std_logic;
signal	EN_T2_SIG: std_logic;
signal	EN_T3_SIG: std_logic;
signal	EN_T4_SIG: std_logic;
signal	PC_EN_SIG: std_logic;
signal	IR_EN_SIG: std_logic;
signal	TEMP_Z_EN_SIG: std_logic;
signal	FLAGC_EN_SIG: std_logic;
signal	FLAGZ_EN_SIG: std_logic;
signal	T1_MUX_SIG: std_logic_vector(1 downto 0);
signal	T2_MUX_SIG: std_logic_vector(1 downto 0);
signal	T3_MUX_SIG: std_logic;
signal	PC_MUX_SIG: std_logic_vector(2 downto 0);

  begin

  A: FSM port map(CLOCK=>CLOCK,RESET=>RESET,IR=>IR_SIG,CARRY_REG=>CaRRY_REG_SIG,ZERO_REG=>ZERO_REG_SIG,T2=>T2_SIG,TEMP_Z=>TEMP_Z_SIG,T4=>T4_SIG, ALU_OP=>ALU_OP_SIG, ALU_A_MUX=>ALU_A_MUX_SIG, ALU_B_MUX=>ALU_B_MUX_SIG,RF_EN=>RF_EN_SIG,R7_WR_MUX=>R7_WR_MUX_SIG,RF_A1_MUX=>RF_A1_MUX_SIG,RF_A3_MUX=>RF_A3_MUX_SIG,RF_D3_MUX=>RF_D3_MUX_SIG,MEM_WRITE_BAR=>MEM_WRITE_BAR_SIG,MEM_A_MUX=>MEM_A_MUX_SIG,MEM_D_MUX=>MEM_D_MUX_SIG,EN_T1=>EN_T1_SIG,EN_T2=>EN_T2_SIG,EN_T3=>EN_T3_SIG,EN_T4=>EN_T4_SIG,PC_EN=>PC_EN_SIG,IR_EN=>IR_EN_SIG,TEMP_Z_EN=>TEMP_Z_EN_SIG,FLAGC_EN=>FLAGC_EN_SIG,FLAGZ_EN=>FLAGZ_EN_SIG,T1_MUX=>T1_MUX_SIG,T2_MUX=>T2_MUX_SIG,T3_MUX=>T3_MUX_SIG,PC_MUX=>PC_MUX_SIG);

  B: datapath port map(CLK=>CLOCK,RESET=>RESET,ALU_OPR=>ALU_OP_SIG, ALU_A_MUX=>ALU_A_MUX_SIG, ALU_B_MUX=>ALU_B_MUX_SIG,RF_EN=>RF_EN_SIG,R7_WR_MUX=>R7_WR_MUX_SIG,RF_A1_MUX=>RF_A1_MUX_SIG,RF_A3_MUX=>RF_A3_MUX_SIG,RF_D3_MUX=>RF_D3_MUX_SIG,MEM_WRITE_BAR=>MEM_WRITE_BAR_SIG,MEM_A_MUX=>MEM_A_MUX_SIG,MEM_D_MUX=>MEM_D_MUX_SIG,EN_T1=>EN_T1_SIG,EN_T2=>EN_T2_SIG,EN_T3=>EN_T3_SIG,EN_T4=>EN_T4_SIG,PC_EN=>PC_EN_SIG,IR_EN=>IR_EN_SIG,TEMP_Z_EN=>TEMP_Z_EN_SIG,FLAGC_EN=>FLAGC_EN_SIG,FLAGZ_EN=>FLAGZ_EN_SIG,T1_MUX=>T1_MUX_SIG,T2_MUX=>T2_MUX_SIG,T3_MUX=>T3_MUX_SIG,PC_MUX=>PC_MUX_SIG,IR_OUT=>IR_SIG,FLAGC=>CARRY_REG_SIG,FLAGZ=>ZERO_REG_SIG,T2_OUT=>T2_SIG,TEMPZ=>TEMP_Z_SIG,T4_OUT=>T4_SIG);
  END BEHAVE;

