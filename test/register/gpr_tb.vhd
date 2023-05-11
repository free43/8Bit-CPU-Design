library ieee;
use ieee.std_logic_1164.all;

entity gpr_tb is
end gpr_tb;

architecture bh of gpr_tb is

	signal clk, reset, a_fetch, b_fetch : std_logic := '0';
	signal data_bus : std_logic_vector(7 downto 0) := x"00";
	signal a, b : std_logic_vector(7 downto 0) := x"00";
	component gpr
        port (
			 clk, reset, a_fetch, b_fetch : in std_logic;
			 data_bus : in std_logic_vector(7 downto 0);  
			 a, b : out std_logic_vector(7 downto 0)  
        ) ;
    end component;
    constant clock_period : time := 10 ns;
begin
    uut:gpr port map(clk => clk, reset => reset, data_bus => data_bus, a => a, b => b, a_fetch => a_fetch, b_fetch => b_fetch);
	 
   process
	begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;
	 
	 process
     begin
	  	  -- set a_out and b_out 0 with reset = 1
	 reset <= '1';
	 data_bus <= x"AA";
	 a_fetch <= '1';
	 b_fetch <= '1';
	 wait for 10 ns;
	 reset <= '0';
	 -- the outputs a and b should be set to x"AA"
	 wait for 10 ns;
	 data_bus <= x"00";
	 wait for 10 ns;
	 -- the outputs a and b should be set to x"00"
	 data_bus <= x"AA";
	 a_fetch <= '0';
	 b_fetch <= '0';
	 wait for 10 ns;
	 -- Values shouldn't be set to a and b, becaus a_fetch and b_fetch = 0
	 a_fetch <= '1';
	 wait for 10 ns;
	 -- Value x"AA" should be set in a
	 -- b should be x"00"
	 data_bus <= x"AF";
	 a_fetch <= '0';
	 b_fetch <= '1';
	 wait for 10 ns;
	 -- Value x"AF" should be set in b
	 -- a should be x"AA"
	 reset <= '1';
	 wait;
	 -- a and b shuld be set to x"00"
	  end process ; -- 
end bh ; -- bh