library ieee;
use ieee.std_logic_1164.all;

entity mar_tb is
end mar_tb;

architecture bh of mar_tb is

	signal clk, reset, mar_fetch : std_logic := '0';
	signal data_bus : std_logic_vector(7 downto 0) := x"00";
	signal mar_out : std_logic_vector(7 downto 0) := x"00";
	component mar
        port (
			 clk, reset, mar_fetch : in std_logic;
			 data_bus : in std_logic_vector(7 downto 0);  
			 mar_out : out std_logic_vector(7 downto 0)  
        ) ;
    end component;
    constant clock_period : time := 10 ns;
begin
    uut:mar port map(clk => clk, reset => reset, data_bus => data_bus, mar_out => mar_out, mar_fetch => mar_fetch);
	 
   process
	begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;
	 
	 process
     begin
	  -- reset
	 reset <= '1';
	 data_bus <= x"AA";
	 mar_fetch <= '1';
	 wait for 10 ns;
	 reset <= '0';
	 -- mar_out should be set to x"AA" 
	 wait for 10 ns;
	 data_bus <= x"00";
	 wait for 10 ns;
	 -- mar_out should be set to x"00"
	 data_bus <= x"AA";
	 mar_fetch <= '0';
	 wait for 10 ns;
	 data_bus <= x"AF";
	 wait for 10 ns;
	 -- set mar_fetch to 0
	 mar_fetch <= '1';
	 wait for 10 ns;
	 -- x"AF" should be written to mar_out
	 reset <= '1';
	 wait;
	 -- reset
	  end process ; -- 
end bh ; -- bh