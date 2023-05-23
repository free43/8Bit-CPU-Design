library ieee;
use ieee.std_logic_1164.all;

entity cpu_tb is
end cpu_tb;

architecture bh of cpu_tb is

	signal clk, reset : std_logic := '0';
   signal port_in0 : std_logic_vector(7 downto 0) := x"00";
   signal port_in1 : std_logic_vector(7 downto 0) := x"00";
   signal port_in2 : std_logic_vector(7 downto 0) := x"00";
   signal port_in3 : std_logic_vector(7 downto 0) := x"00";
   signal port_in4 : std_logic_vector(7 downto 0) := x"00";
   signal port_in5 : std_logic_vector(7 downto 0) := x"00";
   signal port_in6 : std_logic_vector(7 downto 0) := x"00";
   signal port_in7 : std_logic_vector(7 downto 0) := x"00";
   signal port_out0 : std_logic_vector(7 downto 0) := x"00";
   signal port_out1 : std_logic_vector(7 downto 0) := x"00";
   signal port_out2 : std_logic_vector(7 downto 0) := x"00";
   signal port_out3 : std_logic_vector(7 downto 0) := x"00";
   signal port_out4 : std_logic_vector(7 downto 0) := x"00";
   signal port_out5 : std_logic_vector(7 downto 0) := x"00";
   signal port_out6 : std_logic_vector(7 downto 0) := x"00";
   signal port_out7 : std_logic_vector(7 downto 0) := x"00";
	component cpu
        port (
    clk, reset : in std_logic;
    port_in0 : in std_logic_vector(7 downto 0);
    port_in1 : in std_logic_vector(7 downto 0);
    port_in2 : in std_logic_vector(7 downto 0);
    port_in3 : in std_logic_vector(7 downto 0);
    port_in4 : in std_logic_vector(7 downto 0);
    port_in5 : in std_logic_vector(7 downto 0);
    port_in6 : in std_logic_vector(7 downto 0);
    port_in7 : in std_logic_vector(7 downto 0);
    port_out0 : out std_logic_vector(7 downto 0);
    port_out1 : out std_logic_vector(7 downto 0);
    port_out2 : out std_logic_vector(7 downto 0);
    port_out3 : out std_logic_vector(7 downto 0);
    port_out4 : out std_logic_vector(7 downto 0);
    port_out5 : out std_logic_vector(7 downto 0);
    port_out6 : out std_logic_vector(7 downto 0);
    port_out7 : out std_logic_vector(7 downto 0)
	 ) ;
    end component;
    constant clock_period : time := 10 ns;
	 begin
    uut:cpu port map(clk => clk, reset => reset, port_in0 => port_in0, port_in1 => port_in1, port_in2 => port_in2, port_in3 => port_in3,
	 port_in4 => port_in4, port_in5 => port_in5, port_in6 => port_in6, port_in7 => port_in7, port_out0 => port_out0, port_out1 => port_out1,
	 port_out2 => port_out2, port_out3 => port_out3, port_out4 => port_out4, port_out5 => port_out5, port_out6 => port_out6, port_out7 => port_out7);
	 
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
	 wait for clock_period;
	 reset <= '0';
	 wait for clock_period;
	 port_in0 <= x"AA";
	 wait for clock_period;
	 port_in1 <= x"0F";
	 wait;
	 end process ; -- 
end bh ; -- bh