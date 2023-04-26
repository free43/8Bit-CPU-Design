library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity out_mux is
    port(
        address, data_rom, data_rw : in std_logic_vector(7 downto 0);
        port_in0 : in std_logic_vector(7 downto 0);
        port_in1 : in std_logic_vector(7 downto 0);
        port_in2 : in std_logic_vector(7 downto 0);
        port_in3 : in std_logic_vector(7 downto 0);
        port_in4 : in std_logic_vector(7 downto 0);
        port_in5 : in std_logic_vector(7 downto 0);
        port_in6 : in std_logic_vector(7 downto 0);
        port_in7 : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end out_mux;

architecture bh of out_mux is 
begin
    process (address, data_rom, data_rw, port_in0, port_in1, port_in2, port_in3, port_in4, port_in5, port_in6, port_in7)
    begin
        if address >= x"00" and address <= x"7F" then
            data_out <= data_rom;
        elsif address >= x"80" and address <= x"EF" then
            data_out <= data_rw;
        elsif address >= x"F0" and address <= x"F7" then
            case address is
                when x"F0" => data_out <= port_in0;
                when x"F1" => data_out <= port_in1;
                when x"F2" => data_out <= port_in2;
                when x"F3" => data_out <= port_in3;
                when x"F4" => data_out <= port_in4;
                when x"F5" => data_out <= port_in5;
                when x"F6" => data_out <= port_in6;
                when x"F7" => data_out <= port_in7;
                when others => data_out <= x"00";
            end case;
        else 
            data_out <= x"00";
        end if;
    end process;
end bh ; -- bh