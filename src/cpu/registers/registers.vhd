library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is
  port (
    clk, reset, ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch  : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    data_bus0_sel, data_bus1_sel : in std_logic_vector(1 downto 0);
    alu_sel : in std_logic_vector(3 downto 0);
    ir, address, data_out : out std_logic_vector(7 downto 0);
    flags : out std_logic_vector(2 downto 0) -- negativ, zero, carry 
  ) ;
end registers;

architecture bh of registers is

    signal data_bus0, data_bus1 : std_logic_vector(7 downto 0) := x"00";
    signal pc, npc : std_logic_vector(7 downto 0) := x"00";
    signal a_out, b_out : std_logic_vector(7 downto 0) := x"00";
    signal nzc_flags : std_logic_vector(2 downto 0) := "000";
    signal alu_out : std_logic_vector(7 downto 0) := x"00";
    signal alu_flags : std_logic_vector(2 downto 0) := "000";
begin
    register_ir : process( clk, reset )
    begin
        if reset = '1' then
            ir <= x"00";
        elsif rising_edge(clk) then
            if ir_fetch = '1' then
                ir <= data_bus0;
            end if;
        end if;
    end process ; -- register_ir
        
    register_mar : process( clk, reset )
    begin
        if reset = '1' then
            address <= x"00";
        elsif rising_edge(clk) then
            if mar_fetch = '1' then
                address <= data_bus0;
            end if;
        end if;
    end process ; -- register_mar
        
    register_pc : process( clk, reset )
    begin
        if reset = '1' then
            pc <= x"00";
        elsif rising_edge(clk) then
            pc <= npc;
        end if;
    end process ; -- register_pc
    process(pc_fetch, pc_inc, data_bus0, pc)
    begin
        if pc_fetch = '1' then
            npc <= data_bus0;
        elsif pc_inc = '1' then
            npc <= std_logic_vector(unsigned(pc) + 1 );
        else
            npc <= pc;
        end if;
    end process;

    register_a : process( clk, reset )
    begin
        if reset = '1' then
            a_out <= x"00";
        elsif rising_edge(clk) then
            if a_fetch = '1' then
                a_out <= data_bus0;
            end if;
        end if;
    end process ; -- register_a

    register_b : process( clk, reset )
    begin
        if reset = '1' then
            b_out <= x"00";
        elsif rising_edge(clk) then
            if b_fetch = '1' then
                b_out <= data_bus0;
            end if;
        end if;
    end process ; -- register_b

    flag_register : process( clk, reset )
    begin
        if reset = '1' then
            nzc_flags <= "000";
        elsif rising_edge(clk) then
            if flag_fetch = '1'then
                nzc_flags <= alu_flags;
            end if;
        end if;
    end process ; -- flag_register
    flags <= nzc_flags;

    data_bus0_mux : process( data_bus0_sel, data_in, alu_out, data_bus1 )
    begin
        case( data_bus0_sel ) is
        
            when "00" => data_bus0 <= data_bus1;
            when "01" => data_bus0 <= alu_out;
            when "10" => data_bus0 <= data_in;
            when others => data_bus0 <= x"00";
        
        end case ;
    end process ; -- data_bus0_mux

    data_bus1_mux : process( data_bus1_sel, a_out, b_out, npc )
    begin
        case( data_bus1_sel ) is
        
            when "00" => data_bus1 <= npc;
            when "01" => data_bus1 <= a_out;
            when "10" => data_bus1 <= b_out;
            when others => data_bus1 <= x"00";
        
        end case ;
    end process ; -- data_bus1_mux

    data_out <= data_bus1;

end bh ; -- bh