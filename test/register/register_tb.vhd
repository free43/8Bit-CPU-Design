library ieee;
use ieee.std_logic_1164.all;

entity register_tb is
end register_tb;

architecture bh of register_tb is

    signal clk, reset : std_logic := '0';
    constant clock_period : time := 10 ns; 
    signal ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch  : std_logic := '0';
    signal data_in : std_logic_vector(7 downto 0) := x"00";
    signal data_bus0_sel, data_bus1_sel : std_logic_vector(1 downto 0) := "00";
    signal alu_sel : std_logic_vector(3 downto 0) := x"0";
    signal ir, address, data_out : std_logic_vector(7 downto 0) := x"00";
    signal nzc_flags : std_logic_vector(2 downto 0) := "000"; -- negativ, zero, carry 
    component registers 
        port (
          clk, reset, ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch  : in std_logic;
          data_in : in std_logic_vector(7 downto 0);
          data_bus0_sel, data_bus1_sel : in std_logic_vector(1 downto 0);
          alu_sel : in std_logic_vector(3 downto 0);
          ir_out, address, data_out : out std_logic_vector(7 downto 0);
          nzc_flags : out std_logic_vector(2 downto 0) -- negativ, zero, carry 
        ) ;
    end component;
begin

    uut:registers port map( clk, reset, 
                            ir_fetch, mar_fetch, pc_fetch, 
                            pc_inc, a_fetch, b_fetch, flag_fetch, 
                            data_in, data_bus0_sel, data_bus1_sel, alu_sel, 
                            ir, address, data_out,
                            nzc_flags);
    process 
    begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;

    process
    begin
        -- Reset --
        reset <= '1';
        data_in <= x"AA";
        data_bus0_sel <= "10";
		  data_bus1_sel <= "00";
		  alu_sel <= x"0";
        wait for 3 * clock_period;
        reset <= '0';
        wait for clock_period / 2;
        a_fetch <= '1';
        ir_fetch <= '1';
        mar_fetch <= '1';
        pc_fetch <= '1';
        b_fetch <= '1';
        flag_fetch <= '1';
		  -- ir should be x"AA", data_out should be x"AA", address should be x"AA", nzc_flags should be "001"
        wait for clock_period;
		  data_in <= x"01";
		  wait for clock_period;
        data_bus0_sel <= "01";
        data_bus1_sel <= "10";
		  -- data_out should be x"02"
		  wait for clock_period;
		  data_in <= x"80";
		  data_bus0_sel <= "10";
		  data_bus1_sel <= "00";
		  ir_fetch <= '0';
        mar_fetch <= '0';
		  b_fetch <= '0';
		  a_fetch <= '0';
		  wait for 2 * clock_period;
        pc_inc <= '1';
        pc_fetch <= '0';
		  -- data_out should be x"81", ir_out should be x"01", adress should be x"01"
        wait for clock_period;
		  data_bus0_sel <= "00";
		  mar_fetch <= '1';
		  wait for 2 * clock_period;
		  data_in <= x"55";
		  data_bus0_sel <= "10";
		  mar_fetch <= '0';
		  pc_inc <= '0';
		  ir_fetch <= '1';
		  -- ir_out should be x"55", adress should be x"82", data_out should be x"83"
		  wait for 2 * clock_period;
        wait;
    end process;

end bh ; -- bh
