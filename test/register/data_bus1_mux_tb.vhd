library ieee;
use ieee.std_logic_1164.all;

entity data_bus1_mux_tb is
end data_bus1_mux_tb;

architecture bh of data_bus1_mux_tb is
	signal a_in, b_in, pc_in : std_logic_vector(7 downto 0);
   signal data_bus_sel : std_logic_vector(1 downto 0);
   signal data_bus1 : std_logic_vector(7 downto 0); 
	component data_bus1_mux
        port (
		  a_in, b_in, pc_in : in std_logic_vector(7 downto 0);
        data_bus_sel : in std_logic_vector(1 downto 0);
        data_bus1 : out std_logic_vector(7 downto 0) 
        ) ;
    end component;
    constant clock_period : time := 10 ns;
begin
    uut:data_bus1_mux port map(data_bus_sel => data_bus_sel, data_bus1 => data_bus1, a_in => a_in, b_in => b_in, pc_in => pc_in);
	 
	 process
		begin
		data_bus_sel <= "00";
		wait for 10 ns;
		a_in <= x"AA";
		b_in <= x"AF";
		pc_in <= x"FF";
		wait for 10 ns;
		-- data_bus 1 should be set to x"FF"
		data_bus_sel <= "01";
		-- data_bus 1 should be set to x"AA"
		wait for 10 ns;
		a_in <= x"00";
		-- data_bus 1 should be set to x"00"
		wait for 10 ns;
		data_bus_sel <= "10";
		-- data_bus 1 should be set to x"AF"
		wait for 10 ns;
		data_bus_sel <= "11";
		-- data_bus 1 should be set to x"00"
		wait;
	 end process ; -- 
end bh ; -- bh