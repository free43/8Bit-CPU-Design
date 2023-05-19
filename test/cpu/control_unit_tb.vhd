library ieee;
use ieee.std_logic_1164.all;

entity control_unit_tb is
end control_unit_tb;

architecture bh of control_unit_tb is

	signal clk, reset : std_logic := '0';
	signal ir : std_logic_vector(7 downto 0) := x"00";
	signal nzc_alu_flags : std_logic_vector(2 downto 0) := "000";
	signal alu_sel : std_logic_vector(3 downto 0) := x"0";
	signal data_bus0_sel, data_bus1_sel : std_logic_vector(1 downto 0) := "00";
	signal ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch, write_enable : std_logic := '0';
	component control_unit
        port (
    clk, reset : in std_logic;
    ir : in std_logic_vector(7 downto 0);
    nzc_alu_flags : in std_logic_vector(2 downto 0);
    alu_sel : out std_logic_vector(3 downto 0);
    data_bus0_sel, data_bus1_sel : out std_logic_vector(1 downto 0);
    ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch, write_enable : out std_logic
	 ) ;
    end component;
    constant clock_period : time := 10 ns;
	 begin
    uut:control_unit port map(clk => clk, reset => reset, ir => ir, nzc_alu_flags => nzc_alu_flags, alu_sel => alu_sel, data_bus0_sel => data_bus0_sel,
	 data_bus1_sel => data_bus1_sel, ir_fetch => ir_fetch, mar_fetch => mar_fetch, pc_fetch => pc_fetch, pc_inc => pc_inc, a_fetch => a_fetch,
	 flag_fetch => flag_fetch, write_enable => write_enable);
	 
    process
	 begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;
	 
	 process
    begin
		 reset <= '1';
		 wait for clock_period;
		 reset <= '0';
		 wait for 3 * clock_period;
		 ir <= x"00";
	 	 wait;
	 end process ; -- 
end bh ; -- bh