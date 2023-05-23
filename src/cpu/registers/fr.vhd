library ieee;
use ieee.std_logic_1164.all;

entity fr is
  port (
    clk, reset, fr_fetch : in std_logic;
    fr_in : in std_logic_vector(2 downto 0);  
    fr_out : out std_logic_vector(2 downto 0)  
  ) ;
end fr;

architecture bh of fr is

    signal fr_s : std_logic_vector(2 downto 0);

begin
    process( clk, reset )
    begin
        if reset = '1' then
            fr_s <= (others => '0');
        elsif rising_edge(clk) then
            if fr_fetch = '1' then
                fr_s <= fr_in;
            end if;
        end if;
    end process;
    fr_out <= fr_s;

end bh ; -- bh