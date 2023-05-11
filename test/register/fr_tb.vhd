library ieee;
use ieee.std_logic_1164.all;

entity fr_tb is
end fr_tb;

architecture bh of fr_tb is

	signal clk, reset, fr_fetch : std_logic := '0';
	signal fr_in : std_logic_vector(2 downto 0) := "000";
	signal fr_out : std_logic_vector(2 downto 0) := "000";
	component fr
        port (
			 clk, reset, fr_fetch : in std_logic;
			 fr_in : in std_logic_vector(2 downto 0);  
			 fr_out : out std_logic_vector(2 downto 0)  
        ) ;
    end component;
    constant clock_period : time := 10 ns;
begin
    uut:fr port map(clk => clk, reset => reset, fr_in => fr_in, fr_out => fr_out, fr_fetch => fr_fetch);
	 
   process
	begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;
	 process
     begin
	  -- fr_out 0 setzen mit reset = 1
	 reset <= '1';
	 fr_in <= "101";
	 fr_fetch <= '1';
	 wait for 10 ns;
	 reset <= '0';
	 -- nun wird fr_out mit "101" beschrieben
	 wait for 10 ns;
	 fr_in <= "000";
	 wait for 10 ns;
	 -- fr_out wird mit "000" beschrieben
	 fr_in <= "101";
	 fr_fetch <= '0';
	 wait for 10 ns;
	 fr_in <= "111";
	 wait for 10 ns;
	 -- Werte werden nicht nach fr_out übertragen, da fr_fetch = 0 ist
	 fr_fetch <= '1';
	 wait for 10 ns;
	 -- "111" von fr wird in fr_out geschrieben
	 reset <= '1';
	 wait;
	 -- fr_out wird auf "000" zurückgesetzt
	  end process ; -- 
end bh ; -- bh