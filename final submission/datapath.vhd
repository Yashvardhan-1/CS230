library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
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
  FLAGC, FLAGZ: out std_logic;
  T4_OUT: out std_logic_vector(2 downto 0);
  T2_OUT: out std_logic_vector(15 downto 0);
  IR_OUT: out std_logic_vector(15 downto 0);
  TEMPZ: out std_logic
  );
  end entity;

  architecture dp of datapath is

    component ALU is
      port(ALU_OP: in std_logic_vector(2 downto 1);
          ALU_A: in std_logic_vector(15 downto 0);
          ALU_B: in std_logic_vector(15 downto 0);
          ALU_C: out std_logic;
          ALU_Z: out std_logic;
          ALU_OUT: out std_logic_vector(15 downto 0));
    end component;

    component reg is
    Generic (NUM_BITS : INTEGER := 16);
      port (EN, reset, CLK: in std_logic;
            IP: in std_logic_vector(NUM_BITS-1 downto 0);
            OP: out std_logic_vector(NUM_BITS-1 downto 0)
    		  );
    end component;

    component priority_encoder is
    port (
        IP : in std_logic_vector (7 downto 0);
        OP_ADDR : out std_logic_vector (2 downto 0);
        UPDATE : out std_logic_vector (7 downto 0)
      );
    end component priority_encoder;

    component reg_3bit is
      port (
            EN, reset, CLK: in std_logic;
            IP: in std_logic_vector(2 downto 0);
            OP: out std_logic_vector(2 downto 0));
    end component;

    component RegFile is
      port (
          CLK,RESET: in std_logic;
          RF_A1, RF_A2, RF_A3 : in std_logic_vector (2 downto 0);
          RF_D3 : in std_logic_vector(NUM_BITS - 1 downto 0);
          RF_D1, RF_D2 : out std_logic_vector(NUM_BITS - 1 downto 0);
          ALU_TO_R7, T2_TO_R7, PC_TO_R7 : in std_logic_vector (NUM_BITS - 1 downto 0);
          RF_WR: in std_logic;
          R7_WR_MUX : in std_logic_vector(1 downto 0)
        );
	end component;

    component flip_flop is
      port (EN, RESET, CLK: in std_logic;
            D: in std_logic;
            Q: out std_logic);
    end component;

    component memory is
      port(CLK: in std_logic;
          MEM_WRITE_BAR: in std_logic;
          ADDRESS: in std_logic_vector(15 downto 0);
          DATA_IN: in std_logic_vector(15 downto 0);
          DATA_OUT: out std_logic_vector(15 downto 0));
    end component;

    component SE6 is
    port (
        IP : in std_logic_vector (5 downto 0);
        OP : out std_logic_vector (15 downto 0));
    end component SE6;

    component SE9 is
    port (
        IP : in std_logic_vector (8 downto 0);
        OP : out std_logic_vector (15 downto 0));
    end component SE9;

    signal T1_IP,T1_OP, T2_IP, T2_OP, T3_IP, T3_OP : std_logic_vector(15 downto 0);
    signal T4_IP, T4_OP: std_logic_vector(2 downto 0);
    signal MEM_D, IR_OP: std_logic_vector(15 downto 0);
    signal PC_IN, PC_OUT: std_logic_vector(15 downto 0);
    signal ALU_A, ALU_B, ALU_OUT : std_logic_vector(15 downto 0);
	  signal ALU_Z, ALU_C: std_logic;
    signal RF_A1, RF_A2, RF_A3 : std_logic_vector(2 downto 0);
    signal RF_D1, RF_D2, RF_D3, R7_OP : std_logic_vector(15 downto 0);
	  signal T2_UPDATE : std_logic_vector(15 downto 0):=(others=>'0');
    signal MEM_ADDR, MEM_D_IN, MEM_D_OUT : std_logic_vector(15 downto 0);
    signal SE9IR08_OUT, SE6IR05_OUT : std_logic_vector (15 downto 0);

    begin
	 T4_OUT<= T4_OP;
	 IR_OUT <= IR_OP;
	 T2_OUT <= T2_OP;

	-- t2_update(15 downto 8) <= "0";
      T1: reg port map(EN=>EN_T1, RESET=>RESET, CLK=>CLK, IP=>T1_IP, OP=>T1_OP);
      T4: reg_3bit port map(EN=>EN_T4, RESET=>RESET, CLK=>CLK, IP=>T4_IP, OP=>T4_OP);
      T2: reg port map(EN=>EN_T2, RESET=>RESET, CLK=>CLK, IP=>T2_IP, OP=>T2_OP);
      T3: reg port map(EN=>EN_T3, RESET=>RESET, CLK=>CLK, IP=>T3_IP, OP=>T3_OP);

      PC: reg port map(EN=>PC_EN, RESET=>RESET, CLK=>CLK, IP=>PC_IN, OP=>PC_OUT);
      IR: reg port map(EN=>IR_EN, RESET=>RESET, CLK=>CLK, IP=>MEM_D_OUT, OP=>IR_OP);

      ALU_DATAPATH: ALU port map(ALU_OP=>ALU_OPR, ALU_A=>ALU_A, ALU_B=>ALU_B, ALU_C=>ALU_C, ALU_Z=>ALU_Z, ALU_OUT=>ALU_OUT);
      
      Z_FLAG: flip_flop port map(EN=>FLAGZ_EN, RESET=>RESET, CLK=>CLK, D=>ALU_Z, Q=>FLAGZ);
      C_FLAG: flip_flop port map(EN=>FLAGC_EN, RESET=>RESET, CLK=>CLK, D=>ALU_C, Q=>FLAGC);
      
      PE: priority_encoder port map(IP=>T2_OP(7 downto 0), OP_ADDR=>T4_IP, UPDATE=>T2_UPDATE(7 downto 0));
      TEMP_Z: flip_flop port map(EN=>TEMP_Z_EN, RESET=>RESET, CLK=>CLK, D=>ALU_Z, Q=>TEMPZ);

      RF: RegFile port map(
      CLK=>CLK,
		RESET => RESET,
      RF_A1=>RF_A1,
      RF_A2=>IR_OP(8 downto 6),
      RF_A3=>RF_A3,
      RF_D1=>RF_D1,
      RF_D2=>RF_D2,
      RF_D3=>RF_D3,
      ALU_TO_R7=>ALU_OUT,
      T2_TO_R7=>T2_OP,
      PC_TO_R7=>PC_OUT,
      RF_WR=>RF_EN,
      R7_WR_MUX=>R7_WR_MUX
      );

      MEM: memory port map (CLK=>CLK, MEM_WRITE_BAR=>MEM_WRITE_BAR, ADDRESS=>MEM_ADDR, DATA_IN=>MEM_D_IN, DATA_OUT=>MEM_D_OUT);

      SE6_IR_0_5 : SE6 port map (IP=>IR_OP(5 downto 0) , OP=>SE6IR05_OUT);
      SE9_IR_0_8 : SE9 port map (IP=> IR_OP(8 downto 0), OP=>SE9IR08_OUT);
	process(CLK,
	ALU_OPR, ALU_A_MUX, ALU_B_MUX,
	RF_EN,
	R7_WR_MUX, RF_A1_MUX, RF_A3_MUX, RF_D3_MUX,
	MEM_WRITE_BAR, MEM_A_MUX, MEM_D_MUX,
	EN_T1, EN_T2, EN_T3, EN_T4 ,
	PC_EN,
	IR_EN,
	FLAGC_EN, FLAGZ_EN,
	T1_MUX, T2_MUX, T3_MUX,
	PC_MUX,
	TEMP_Z_EN,
	PC_OUT, IR_OP,
	T1_OP, T2_OP, T3_OP, T4_OP,
	SE9IR08_OUT, SE6IR05_OUT,
	MEM_D_OUT, RF_D1, RF_D2,
	T2_UPDATE, ALU_OUT
  )
  begin
      case(ALU_A_MUX) is
        when "00"=>
          ALU_A <= PC_OUT;
        when "11"=>
          ALU_A <= SE9IR08_OUT;
        when "10"=>
          ALU_A <= T2_OP;
        when "01"=>
          ALU_A <= T1_OP;
			when others =>
				ALU_A <= (others => '0');
      end case;

      case(ALU_B_MUX) is
        when "000"=>
          ALU_B(15 downto 0)<=(others=>'0');
        when "010"=>
          ALU_B <= T2_OP;
        when "011"=>
          ALU_B <= T3_OP;
        when "100"=>
          ALU_B <= SE6IR05_OUT;
        when "001"=>
          ALU_B(15 downto 1) <= (others=>'0');
          ALU_B(0) <= '1';
        when "101"=>
            ALU_B <= SE9IR08_OUT;
        when others =>
          ALU_B(15 downto 0) <= (others=>'0');
      end case;

      case(RF_A1_MUX) is
        when "00"=>
          RF_A1 <= IR_OP(11 downto 9);
        when "10"=>
          RF_A1 <= T4_OP;
        when "01"=>
          RF_A1 <= "111";
			  when others =>
				  RF_A1 <= (others => '0');
      end case;

      case(RF_A3_MUX) is
        when "001"=>
          RF_A3 <= IR_OP(5 downto 3);
        when "011"=>
          RF_A3 <= IR_OP(8 downto 6);
        when "010"=>
          RF_A3 <= "111";
        when "101"=>
          RF_A3 <= T4_OP;
        when "100"=>
          RF_A3 <= IR_OP(11 downto 9);
        when others =>
          RF_A3 <= "111";
      end case;

      case(RF_D3_MUX) is
        when "00"=>
          RF_D3 <= T1_OP;
        when "10"=>
          RF_D3 <= T3_OP;
        when "01"=>
          RF_D3(15 downto 7) <= IR_OP(8 downto 0);
          RF_D3(6 downto 0) <= (others=>'0');
        when others =>
          RF_D3 <= (others => '0');
      end case;

      case(MEM_A_MUX) is
        when "00"=>
          MEM_ADDR <= PC_OUT;
        when "10"=>
          MEM_ADDR <= T2_OP;
        when "01"=>
          MEM_ADDR <= T1_OP;
			  when others =>
				  MEM_ADDR <= (others => '0');
      end case;

      case(MEM_D_MUX) is
        when '1'=>
          MEM_D_IN <= T3_OP;
        when '0'=>
          MEM_D_IN <= T1_OP;
			  when others =>
				  MEM_D_IN <= (others => '0');
      end case;

      case(T1_MUX) is
        when "00"=>
          T1_IP <= RF_D1;
        when "10"=>
          T1_IP <= MEM_D_OUT;
        when "01"=>
          T1_IP <= ALU_OUT;
        when others =>
          T1_IP <= (others => '0');
      end case;

      case(T2_MUX) is
        when "00"=>
          T2_IP <= RF_D2;
        when "11"=>
          T2_IP <= T2_UPDATE;
        when "10"=>
          T2_IP <= SE9IR08_OUT;
        when "01"=>
          T2_IP <= ALU_OUT;
        when others =>
          T2_IP <= (others => '0');
      end case;

      case(T3_MUX) is
        when '1'=>
          T3_IP <= RF_D1;
        when '0'=>
          T3_IP <= MEM_D_OUT;
        when others =>
          T3_IP <= (others => '0');			 
      end case;

    case(PC_MUX) is
      when "000"=>
        PC_IN <= ALU_OUT;
      when "010"=>
        PC_IN <= T1_OP;
      when "011"=>
        PC_IN <= T2_OP;
      when "001"=>
        PC_IN <= RF_D1;
      when "101"=>
        PC_IN(15 downto 7) <= IR_OP(8 downto 0);
        PC_IN(6 downto 0) <= (others=>'0');
      when "100"=>
        PC_IN <= T3_OP;
      when others =>
        PC_IN <= (others => '0');
    end case;
  end process;
end architecture;
