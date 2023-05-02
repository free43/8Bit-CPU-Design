library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.instructions.all;
entity rom_memory is
    port(
        clk : in std_logic;
        address : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end rom_memory;

architecture bh of rom_memory is 
    type rom is array (0 to 127) of std_logic_vector(7 downto 0);
    signal enable : std_logic := '0';
    constant my_rom : rom := (      0 => LDA_IMM,
                                    1 => LDA_IMM,
                                    2 => LDA_DIR,
                                    3 => LDB_IMM,
                                    4 => LDB_DIR, 
                                    others => x"00" );
begin
    enable <= '1' when address >= x"00" and address <= x"7F" else '0';
    process(clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                data_out <= my_rom(to_integer(unsigned(address)));
            end if;
        end if;
    end process;
end bh ; -- bh