library ieee;
use ieee.std_logic_1164.all;

entity gpr is
  port (
    clk, reset, a_fetch, b_fetch : in std_logic;
    data_bus : in std_logic_vector(7 downto 0);  
    a, b : out std_logic_vector(7 downto 0)  
  ) ;
end gpr;

architecture bh of gpr is

    signal a_s : std_logic_vector(7 downto 0);
    signal b_s : std_logic_vector(7 downto 0);

begin
    ra:process( clk, reset )
    begin
        if reset = '1' then
            a_s <= x"00";
        elsif rising_edge(clk) then
            if a_fetch = '1' then
                a_s <= data_bus;
            end if;
        end if;
    end process;
    a <= a_s;

    rb:process( clk, reset )
    begin
        if reset = '1' then
            b_s <= x"00";
        elsif rising_edge(clk) then
            if b_fetch = '1' then
                b_s <= data_bus;
            end if;
        end if;
    end process;
    b <= b_s;

end bh ; -- bh