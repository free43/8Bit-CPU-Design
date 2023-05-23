library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture bh of alu_tb is

    signal a, b, alu_out : std_logic_vector(7 downto 0) := x"00";
    signal alu_sel : std_logic_vector(3 downto 0) := x"0";
    signal zcn_flags : std_logic_vector(2 downto 0);
    component alu 
        port (
          a, b : in std_logic_vector(7 downto 0);
          alu_out : out std_logic_vector(7 downto 0);
          alu_sel : in std_logic_vector(3 downto 0);
          zero, carry, negativ : out std_logic
        ) ;
    end component;
    constant wait_time : time := 10 ns;
begin
    uut:alu port map(a => a, b => b, alu_out => alu_out, alu_sel => alu_sel, zero => zcn_flags(2), carry => zcn_flags(1), negativ => zcn_flags(0));

    process
    begin
        -- Add --
        a <= x"00";
        b <= x"00";
        alu_sel <= x"0";
        wait for wait_time;
        a <= x"1F";
        b <= x"1F";
        wait for wait_time;
        a <= x"08";
        b <= x"80";
        wait for wait_time;
        a <= x"FF";
        b <= x"FF";
        wait for wait_time;
        -- Sub --
        alu_sel <= x"1";
        a <= x"01";
        b <= x"01";
        wait for wait_time;
        a <= x"7F";
        b <= x"80";
        wait for wait_time;
        a <= x"03";
        b <= x"01";
        wait for wait_time;
        -- And --
        alu_sel <= x"2";
        a <= x"03";
        b <= x"01";
        wait for wait_time;
        a <= x"01";
        b <= x"FE";
        wait for wait_time;
        -- Or --
        alu_sel <= x"3";
        a <= x"01";
        b <= x"FE";
        wait for wait_time;
        a <= x"00";
        b <= x"00";
        wait for wait_time;
        -- Inc A--
        alu_sel <= x"4";
        a <= x"00";
        wait for wait_time;
        a <= x"FF";
        wait for wait_time;
        a <= x"7F";
        wait for wait_time;
        -- Inc B --
        alu_sel <= x"5";
        b <= x"00";
        wait for wait_time;
        b <= x"FF";
        wait for wait_time;
        b <= x"7F";
        wait for wait_time;
        -- Dec A --
        alu_sel <= x"6";
        a <= x"01";
        wait for wait_time;
        a <= x"FF";
        wait for wait_time;
        a <= x"00";
        wait for wait_time;
        -- Dec B --
        alu_sel <= x"7";
        b <= x"01";
        wait for wait_time;
        b <= x"FF";
        wait for wait_time;
        b <= x"00";
        wait for wait_time;
        -- Not valid input --
        alu_sel <= x"8";
        wait;
    end process ; -- 
end bh ; -- bh