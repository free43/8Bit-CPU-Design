library ieee;
use ieee.std_logic_1164.all;

entity registers_tb is
end registers_tb;

architecture bh of registers_tb is

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
          ir, address, data_out : out std_logic_vector(7 downto 0);
          nzc_flags : out std_logic_vector(2 downto 0) -- negativ, zero, carry 
        ) ;
    end component;
begin
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
        data_in <= x"AA";
        wait for 3 * clock_period;
        reset <= '0';
        wait for clock_period / 2;
        ir_fetch <= '1';
        mar_fetch <= '1';
        pc_fetch <= '1';
        a_fetch <= '1';
        b_fetch <= '1';
        flag_fetch <= '1';
        data_bus0_sel <= "10";
        wait;
    end process;

end bh ; -- bh
