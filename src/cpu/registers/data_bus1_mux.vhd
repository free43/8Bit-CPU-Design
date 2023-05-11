library ieee;
use ieee.std_logic_1164.all;

entity data_bus1_mux is
    port(
        a_in, b_in, pc_in : in std_logic_vector(7 downto 0);
        data_bus_sel : in std_logic_vector(1 downto 0);
        data_bus1 : out std_logic_vector(7 downto 0)
    );
end;

architecture bh of data_bus1_mux is
begin
    process( data_bus_sel, a_in, b_in, pc_in )
    begin
        case( data_bus_sel ) is
            when "00" => data_bus1 <= pc_in;
            when "01" => data_bus1 <= a_in;
            when "10" => data_bus1 <= b_in;
            when others => data_bus1 <= x"00";
        end case ;
    end process ;
end bh ; -- bh