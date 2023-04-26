library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity out_ports is
    port(
        clk, reset, write_enable : in std_logic;
        address, data_in : in std_logic_vector(7 downto 0);
        port_out0 : out std_logic_vector(7 downto 0);
        port_out1 : out std_logic_vector(7 downto 0);
        port_out2 : out std_logic_vector(7 downto 0);
        port_out3 : out std_logic_vector(7 downto 0);
        port_out4 : out std_logic_vector(7 downto 0);
        port_out5 : out std_logic_vector(7 downto 0);
        port_out6 : out std_logic_vector(7 downto 0);
        port_out7 : out std_logic_vector(7 downto 0)
    );
end out_ports;

architecture bh of out_ports is 
begin
    --Address F8--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out0 <= x"00";
        elsif rising_edge(clk) then
            if address = x"F8" and write_enable = '1' then
                port_out0 <= data_in;
            end if;
        end if;
    end process;
    --Address F9--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out1 <= x"00";
        elsif rising_edge(clk) then
            if address = x"F9" and write_enable = '1' then
                port_out1 <= data_in;
            end if;
        end if;
    end process;
    --Address FA--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out2 <= x"00";
        elsif rising_edge(clk) then
            if address = x"FA" and write_enable = '1' then
                port_out2 <= data_in;
            end if;
        end if;
    end process;
    --Address FB--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out3 <= x"00";
        elsif rising_edge(clk) then
            if address = x"FB" and write_enable = '1' then
                port_out3 <= data_in;
            end if;
        end if;
    end process;
    --Address FC--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out4 <= x"00";
        elsif rising_edge(clk) then
            if address = x"FC" and write_enable = '1' then
                port_out4 <= data_in;
            end if;
        end if;
    end process;
    --Address FD--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out5 <= x"00";
        elsif rising_edge(clk) then
            if address = x"FD" and write_enable = '1' then
                port_out5 <= data_in;
            end if;
        end if;
    end process;
    --Address FE--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out6 <= x"00";
        elsif rising_edge(clk) then
            if address = x"FE" and write_enable = '1' then
                port_out6 <= data_in;
            end if;
        end if;
    end process;
    --Address FF--
    process(clk, reset)
    begin
        if reset = '1' then
            port_out7 <= x"00";
        elsif rising_edge(clk) then
            if address = x"FF" and write_enable = '1' then
                port_out7 <= data_in;
            end if;
        end if;
    end process;
    
end bh ; -- bh