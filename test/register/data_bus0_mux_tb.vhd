library ieee;
use ieee.std_logic_1164.all;

entity data_bus0_mux_tb is
end data_bus0_mux_tb;

architecture bh of data_bus0_mux_tb is

	signal data_bus1, alu_in, data_in : std_logic_vector(7 downto 0) := (others => '0');
	signal data_bus0_sel : std_logic_vector(1 downto 0) := (others => '0');
	signal data_bus0 : std_logic_vector(7 downto 0); 
	component data_bus0_mux
		port (
		  	data_bus1, alu_in, data_in: in std_logic_vector(7 downto 0);
			data_bus0_sel : in std_logic_vector(1 downto 0);
		  	data_bus0 : out std_logic_vector(7 downto 0)  
		) ;
	end component;

begin
    uut:data_bus0_mux port map(
		data_bus1 => data_bus1, 
		alu_in => alu_in, 
		data_in => data_in, 
		data_bus0_sel => data_bus0_sel,
		data_bus0 => data_bus0
	);
	 
	 
	process
    begin
		-- Set input to different values
	 	data_bus1 <= x"AB";
	 	alu_in <= x"AC";
	 	data_in <= x"AD";
	 	data_bus0_sel <= "00";
	 	wait for 10 ns;
	 	data_bus0_sel <= "01";
	 	wait for 10 ns;
	 	data_bus0_sel <= "10";
	 	wait for 10 ns;
	 	data_bus0_sel <= "11";
	 	wait;
	end process ; -- 
end bh ; -- bh