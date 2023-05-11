library ieee;
use ieee.std_logic_1164.all;

entity pc_tb is
end pc_tb;

architecture bh of pc_tb is

	signal clk, reset, pc_fetch, pc_inc : std_logic := '0';
	signal data_bus : std_logic_vector(7 downto 0) := x"00";
	signal pc_out : std_logic_vector(7 downto 0) := x"00";
	component pc 
        port (
			 clk, reset, pc_fetch, pc_inc : in std_logic;
			 data_bus : in std_logic_vector(7 downto 0);  
			 pc_out : out std_logic_vector(7 downto 0)  
        ) ;
    end component;
    constant clock_period : time := 10 ns;

begin
    uut:pc port map(clk => clk, reset => reset, pc_inc => pc_inc, data_bus => data_bus, pc_out => pc_out, pc_fetch => pc_fetch);
	 
    process
	begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;
	 
	 process
    begin
	 --  pc_out should be set to 0 with reset = 1
	 reset <= '1';
	 data_bus <= x"AA";
	 pc_fetch <= '1';
	 wait for 10 ns;
	 reset <= '0';
	 -- Value x"AA" should be set to pc_out, because reset = 0
	 wait for 10 ns;
	 data_bus <= x"00";
	 wait for 10 ns;
	 data_bus <= x"AA";
	 pc_fetch <= '0';
	 wait for 10 ns;
	 data_bus <= x"AF";
	 wait for 10 ns;
	 -- Value x"AF" shouldn't be set to pc_out, becuase pc_fetch = 0
	 pc_inc <= '1';
	 wait for 40 ns;
	 pc_inc <= '0';
	 wait for 10 ns;
	  -- pc_out is incremented until pc_inc is 0 again
	 pc_fetch <= '1';
	 pc_inc <= '1';
	 wait for 10 ns;
	 pc_inc <= '0';
	 pc_fetch <= '0';
	 data_bus <= x"AA";
	 wait for 10 ns;
	 pc_inc <= '1';
	 pc_fetch <= '1';
	 -- the value of data_bus is preferred to pc_inc
	 wait for 10 ns;
	 pc_inc <= '0';
	 pc_fetch <= '0';
	 wait for 10 ns;
	 pc_inc <= '1';
	 wait for 10 ns;
	 pc_inc <= '0';
	 wait for 10 ns;
	 pc_inc <= '1';
	 -- pc_inc is summed up to the data_out value
	 wait for 10 ns;
	 reset <= '1';
	 -- if reset = 1, pc_out should be set back to 0
	 wait;
	 end process ; -- 
end bh ; -- bh