library ieee;
use ieee.std_logic_1164.all;

entity ir_tb is
end ir_tb;

architecture bh of ir_tb is

	signal clk, reset, ir_fetch : std_logic := '0';
	signal data_bus : std_logic_vector(7 downto 0) := x"00";
	signal ir_out : std_logic_vector(7 downto 0) := x"00";
	component ir
        port (
			 clk, reset, ir_fetch : in std_logic;
			 data_bus : in std_logic_vector(7 downto 0);  
			 ir_out : out std_logic_vector(7 downto 0)  
        ) ;
    end component;
    constant clock_period : time := 10 ns;
begin
    uut:ir port map(clk => clk, reset => reset, data_bus => data_bus, ir_out => ir_out, ir_fetch => ir_fetch);
	 
   process
	begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;
	 
	 process
		begin
	  -- ir_out set to with reset = 1
	 reset <= '1';
	 data_bus <= x"AA";
	 ir_fetch <= '1';
	 wait for 10 ns;
	 reset <= '0';
	 -- ir_out set to x"AA" 
	 wait for 10 ns;
	 data_bus <= x"00";
	 wait for 10 ns;
	 -- ir_out set to x"00" 
	 data_bus <= x"AA";
	 ir_fetch <= '0';
	 wait for 10 ns;
	 data_bus <= x"AF";
	 wait for 10 ns;
	 -- ir_out should not be changed, because ir_fetch is 0
	 ir_fetch <= '1';
	 wait for 10 ns;
	 -- set ir_out to x"AF"
	 reset <= '1';
	 wait;
	 -- ir_out should be reseted
	  end process ; -- 
end bh ; -- bh