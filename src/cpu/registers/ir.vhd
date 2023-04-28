library ieee;
use ieee.std_logic_1164.all;

entity ir is
  port (
    clk, reset, ir_fetch : in std_logic;
    data_bus : in std_logic_vector(7 downto 0);  
    ir_out : out std_logic_vector(7 downto 0)  
  ) ;
end ir;

architecture bh of ir is

    signal ir_s : std_logic_vector(7 downto 0);

begin
    process( clk, reset )
    begin
        if reset = '1' then
            ir_s <= x"00";
        elsif rising_edge(clk) then
            if ir_fetch = '1' then
                ir_s <= data_bus;
            end if;
        end if;
    end process;
    ir_out <= ir_s;

end bh ; -- bh