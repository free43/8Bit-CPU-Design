library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
  port (
    clk, reset, pc_fetch, pc_inc : in std_logic;
    data_bus : in std_logic_vector(7 downto 0);  
    pc_out : out std_logic_vector(7 downto 0)  
  ) ;
end pc;

architecture bh of pc is

    signal pc_s : std_logic_vector(7 downto 0);

begin
    process( clk, reset )
    begin
        if reset = '1' then
            pc_s <= x"00";
        elsif rising_edge(clk) then
            if pc_fetch = '1' then
                pc_s <= data_bus;
            elsif pc_inc = '1' then
                pc_s <= std_logic_vector(unsigned(pc_s) + to_unsigned(1, pc_s'length));
            end if;
        end if;
    end process;
    pc_out <= pc_s;

end bh ; -- bh