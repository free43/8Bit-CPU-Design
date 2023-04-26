library ieee;
use ieee.std_logic_1164.all;

entity memory_tb is
end memory_tb;

architecture bh of memory_tb is

    signal clk, reset : std_logic := '0';
    constant clock_period : time := 10 ns;
    signal write_enable : std_logic := '0';
    signal address, data_in : std_logic_vector(7 downto 0) := x"00";
    signal port_in0 : std_logic_vector(7 downto 0) := x"0A";
    signal port_in1 : std_logic_vector(7 downto 0) := x"0B";
    signal port_in2 : std_logic_vector(7 downto 0) := x"0C";
    signal port_in3 : std_logic_vector(7 downto 0) := x"0D";
    signal port_in4 : std_logic_vector(7 downto 0) := x"0E";
    signal port_in5 : std_logic_vector(7 downto 0) := x"0F";
    signal port_in6 : std_logic_vector(7 downto 0) := x"10";
    signal port_in7 : std_logic_vector(7 downto 0) := x"11";
    signal port_out0 : std_logic_vector(7 downto 0);
    signal port_out1 : std_logic_vector(7 downto 0);
    signal port_out2 : std_logic_vector(7 downto 0);
    signal port_out3 : std_logic_vector(7 downto 0);
    signal port_out4 : std_logic_vector(7 downto 0);
    signal port_out5 : std_logic_vector(7 downto 0);
    signal port_out6 : std_logic_vector(7 downto 0);
    signal port_out7 : std_logic_vector(7 downto 0);
    signal data_out : std_logic_vector(7 downto 0);
    component memory
        port (
          clk, reset, write_enable : in std_logic;
          address, data_in : in std_logic_vector(7 downto 0);
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
          port_out7 : out std_logic_vector(7 downto 0);
          data_out : out std_logic_vector(7 downto 0)
          );
    end component;
          
          
    begin
        uut:memory port map(
            clk => clk, reset => reset, write_enable => write_enable,
            address => address, data_in => data_in,
            port_in0 => port_in0,
            port_in1 => port_in1,
            port_in2 => port_in2,
            port_in3 => port_in3,
            port_in4 => port_in4,
            port_in5 => port_in5,
            port_in6 => port_in6,
            port_in7 => port_in7,
            port_out0 => port_out0,
            port_out1 => port_out1,
            port_out2 => port_out2,
            port_out3 => port_out3,
            port_out4 => port_out4,
            port_out5 => port_out5,
            port_out6 => port_out6,
            port_out7 => port_out7,
            data_out => data_out
        );
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
        wait for 3 * clock_period;
        reset <= '0';
        address <= x"00";
        write_enable <= '1';
        data_in <= x"AA";
        wait for clock_period;
        address <= x"80";
        write_enable <= '1';
        data_in <= x"AA";
        wait for clock_period;
        write_enable <= '0';
        wait for clock_period;
        address <= x"F0";
        wait for clock_period;
        address <= x"F8";
        write_enable <= '1';
        data_in <= x"AA";
        wait;
    end process;


end bh ; -- bh