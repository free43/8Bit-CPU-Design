library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rw_memory is
    port(
        clk, write_enable : in std_logic;
        address, data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end rw_memory;

architecture bh of rw_memory is 
    type rwm is array (128 to 239) of std_logic_vector(7 downto 0);
    signal enable : std_logic := '0';
    signal my_rwm : rwm := ( others => x"00" );
begin
    enable <= '1' when address >= x"80" and address <= x"EF" else '0';
    process(clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                if write_enable = '1' then
                    my_rwm(to_integer(unsigned(address))) <= data_in;
                end if;
                data_out <= my_rwm(to_integer(unsigned(address)));
            end if;
        end if;
    end process;
end bh ; -- bh