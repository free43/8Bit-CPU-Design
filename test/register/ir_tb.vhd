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
	  	  -- ir_out 0 setzen mit reset = 1
	 reset <= '1';
	 data_bus <= x"AA";
	 ir_fetch <= '1';
	 wait for 10 ns;
	 reset <= '0';
	 -- nun wird ir_out mit x"AA" beschrieben
	 wait for 10 ns;
	 data_bus <= x"00";
	 wait for 10 ns;
	 -- ir_out wird mit x"00" beschrieben
	 data_bus <= x"AA";
	 ir_fetch <= '0';
	 wait for 10 ns;
	 data_bus <= x"AF";
	 wait for 10 ns;
	 -- Werte werden nicht nach ir_out übertragen, da ir_fetch = 0 ist
	 ir_fetch <= '1';
	 wait for 10 ns;
	 -- x"AF" von data_bus wird in ir_out geschrieben
	 reset <= '1';
	 wait;
	 -- ir_out wird auf x"00" zurückgesetzt
	  end process ; -- 
end bh ; -- bh