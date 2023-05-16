library ieee;
use ieee.std_logic_1164.all;
use work.instructions.all;

entity control_unit is
  port (
    clk, reset : in std_logic;
    ir : in std_logic_vector(7 downto 0);
    nzc_alu_flags : in std_logic_vector(2 downto 0);
    data_bus0_sel, data_bus1_sel : out std_logic_vector(1 downto 0);
    ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch, write_enable : out std_logic
  ) ;
end control_unit;

architecture bh of control_unit is

    type ST is (
        IR_Fetch_0,
        IR_Fetch_1,
        IR_Fetch_2,
        ID_3,
        -- Load states --
            -- Immediate --
                LDA_IMM_4,
                LDA_IMM_5,
                LDA_IMM_6,
                LDB_IMM_4,
                LDB_IMM_5,
                LDB_IMM_6,
            -- Directe --
                LDA_DIR_4,
                LDA_DIR_5,
                LDA_DIR_6,
                LDA_DIR_7,
                LDB_DIR_4,
                LDB_DIR_5,
                LDB_DIR_6,
                LDB_DIR_7,
        -- Store states --
            STA_DIR_4,
            STA_DIR_5,
            STA_DIR_6,
            STA_DIR_7,
            STB_DIR_4,
            STB_DIR_5,
            STB_DIR_6,
            STB_DIR_7
        -- Other states --
    );
    signal q_s, q_ns : ST := IR_Fetch_0;
begin
    csr : process( clk, reset )
    begin
        if reset = '1' then
            q_s <= IR_Fetch_0;
        elsif rising_edge(clk) then
            q_s <= q_ns;
        end if;
    end process ; -- csr

    nsd : process( q_s, ir, nzc_alu_flags  )
    begin
        case( q_s ) is
            when IR_Fetch_0 => q_ns <= IR_Fetch_1;
            when IR_Fetch_1 => q_ns <= IR_Fetch_2;
            when IR_Fetch_2 => q_ns <= ID_3;
            when ID_3 => 
                case( ir ) is
                    when LDA_IMM => q_ns <= LDA_IMM_4;
                    when LDB_IMM => q_ns <= LDB_IMM_4;
                    when LDA_DIR => q_ns <= LDA_DIR_4;
                    when LDB_DIR => q_ns <= LDB_DIR_4;
                    when STA_DIR => q_ns <= STA_DIR_4;
                    when STB_DIR => q_ns <= STB_DIR_4;
                    when others => q_ns <= IR_Fetch_0;
                end case ;
            -- Load --
                -- Immediate --
                    when LDA_IMM_4 => q_ns <= LDA_IMM_5;
                    when LDA_IMM_5 => q_ns <= LDA_IMM_6;
                    when LDA_IMM_6 => q_ns <= IR_Fetch_0;
                    when LDB_IMM_4 => q_ns <= LDB_IMM_5;
                    when LDB_IMM_5 => q_ns <= LDB_IMM_6;
                    when LDB_IMM_6 => q_ns <= IR_Fetch_0;
                -- Directe --
                    when LDA_DIR_4 => q_ns <= LDA_DIR_5;
                    when LDA_DIR_5 => q_ns <= LDA_DIR_6;
                    when LDA_DIR_6 => q_ns <= LDA_DIR_7;
                    when LDA_DIR_7 => q_ns <= IR_Fetch_0;
                    when LDB_DIR_4 => q_ns <= LDB_DIR_5;
                    when LDB_DIR_5 => q_ns <= LDB_DIR_6;
                    when LDB_DIR_6 => q_ns <= LDB_DIR_7;
                    when LDB_DIR_7 => q_ns <= IR_Fetch_0;
            -- Store --
                when STA_DIR_4 => q_ns <= STA_DIR_5;
                when STA_DIR_5 => q_ns <= STA_DIR_6;
                when STA_DIR_6 => q_ns <= STA_DIR_7;
                when STA_DIR_7 => q_ns <= IR_Fetch_0;
                when STB_DIR_4 => q_ns <= STB_DIR_5;
                when STB_DIR_5 => q_ns <= STB_DIR_6;
                when STB_DIR_6 => q_ns <= STB_DIR_7;
                when STB_DIR_7 => q_ns <= IR_Fetch_0;       
            when others => q_ns <= IR_Fetch_0;
        end case ;
    end process ; -- nsd

    od : process( q_s )
    begin
        ir_fetch <= '0'; mar_fetch <= '0'; pc_fetch <= '0'; pc_inc <= '0'; a_fetch <= '0'; b_fetch <= '0'; flag_fetch <= '0'; write_enable <= '0';
        data_bus0_sel <= "00"; data_bus1_sel <= "00";
        case( q_s ) is
            when IR_Fetch_0 => data_bus0_sel <= "00"; data_bus1_sel <= "00"; mar_fetch <= '1';
            when IR_Fetch_1 => pc_inc <= '1';
            when IR_Fetch_2 => ir_fetch <= '1'; data_bus0_sel <= "10";
            -- Load --
                -- Immediate --
                    when LDA_IMM_4 => mar_fetch <= '1'; data_bus0_sel <= "00"; data_bus1_sel <= "00";
                    when LDA_IMM_5 => pc_inc <= '1';
                    when LDA_IMM_6 => a_fetch <= '1'; data_bus0_sel <= "10";
                    when LDB_IMM_4 => mar_fetch <= '1'; data_bus0_sel <= "00"; data_bus1_sel <= "00";
                    when LDB_IMM_5 => pc_inc <= '1';
                    when LDB_IMM_6 => b_fetch <= '1'; data_bus0_sel <= "10";
                -- Directe --
                    when LDA_DIR_4 => mar_fetch <= '1'; data_bus0_sel <= "00"; data_bus1_sel <= "00";
                    when LDA_DIR_5 => mar_fetch <= '1'; data_bus0_sel <= "10";
                    when LDA_DIR_6 => pc_inc <= '1';
                    when LDA_DIR_7 => a_fetch <= '1'; data_bus0_sel <= "10";
                    when LDB_DIR_4 => mar_fetch <= '1'; data_bus0_sel <= "00"; data_bus1_sel <= "00";
                    when LDB_DIR_5 => mar_fetch <= '1'; data_bus0_sel <= "10";
                    when LDB_DIR_6 => pc_inc <= '1';
                    when LDB_DIR_7 => a_fetch <= '1'; data_bus0_sel <= "10"; 
            -- Store --
                when STA_DIR_4 => mar_fetch <= '1'; data_bus0_sel <= "00"; data_bus1_sel <= "00";
                when STA_DIR_5 => pc_inc <= '1';
                when STA_DIR_6 => data_bus0_sel <= "10"; mar_fetch <= '1';
                when STA_DIR_7 => data_bus1_sel <= "01"; write_enable <= '1';
                when STB_DIR_4 => mar_fetch <= '1'; data_bus0_sel <= "00"; data_bus1_sel <= "00";
                when STB_DIR_5 => pc_inc <= '1';
                when STB_DIR_6 => data_bus0_sel <= "10"; mar_fetch <= '1';
                when STB_DIR_7 => data_bus1_sel <= "10"; write_enable <= '1';       
            when others =>  ir_fetch <= '0'; mar_fetch <= '0'; pc_fetch <= '0'; pc_inc <= '0'; a_fetch <= '0'; b_fetch <= '0'; flag_fetch <= '0'; write_enable <= '0';
                            data_bus0_sel <= "00"; data_bus1_sel <= "00";
        end case ;
    end process ; -- od

end bh ; -- bh