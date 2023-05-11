library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_bus0_mux is
  port (
    data_bus1, alu_in, data_in: in std_logic_vector(7 downto 0);
	 data_bus0_sel : in std_logic_vector(1 downto 0);
    data_bus0 : out std_logic_vector(7 downto 0)  
  ) ;
end data_bus0_mux;

architecture bh of data_bus0_mux is
    
begin

    
    data_bus0_mux : process( data_bus0_sel, data_in, alu_in, data_bus1)
    begin
        case( data_bus0_sel ) is
        
            when "00" => data_bus0 <= data_bus1;
            when "01" => data_bus0 <= alu_in;
            when "10" => data_bus0 <= data_in;
            when others => data_bus0 <= x"00";
        
        end case ;
    end process ; -- data_bus0_mux
end bh ; -- bh