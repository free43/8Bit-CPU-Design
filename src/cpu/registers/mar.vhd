library ieee;
use ieee.std_logic_1164.all;

entity mar is
  port (
    clk, reset, mar_fetch : in std_logic;
    data_bus : in std_logic_vector(7 downto 0);  
    mar_out : out std_logic_vector(7 downto 0)  
  ) ;
end mar;

architecture bh of mar is

    signal mar_s : std_logic_vector(7 downto 0);

begin
    process( clk, reset )
    begin
        if reset = '1' then
            mar_s <= x"00";
        elsif rising_edge(clk) then
            if mar_fetch = '1' then
                mar_s <= data_bus;
            end if;
        end if;
    end process;
    mar_out <= mar_s;

end bh ; -- bh