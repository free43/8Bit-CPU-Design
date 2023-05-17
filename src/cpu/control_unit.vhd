library ieee;
use ieee.std_logic_1164.all;
use work.instructions.all;
use work.alu_cmds.all;

entity control_unit is
  port (
    clk, reset : in std_logic;
    ir : in std_logic_vector(7 downto 0);
    nzc_alu_flags : in std_logic_vector(2 downto 0);
    alu_sel : out std_logic_vector(3 downto 0);
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
            STB_DIR_7,
        -- Arithmetic and Logic --
            ADD_AB_4,
            SUB_AB_4,
            AND_AB_4,
            OR_AB_4,
            INC_A_4,
            INC_B_4,
            DEC_A_4,
            DEC_B_4,
        -- Branches --
            JMP_4,
            JMP_5,
            JMP_6,
            -- Zero --
                JMP_IZ_4,
                JMP_IZ_5,
                JMP_NZ_4,
                JMP_NZ_5,
            -- Carry --
                JMP_IC_4,
                JMP_IC_5,
                JMP_NC_4,
                JMP_NC_5,
            -- Negativ --
                JMP_IN_4,
                JMP_IN_5,
                JMP_NN_4,
                JMP_NN_5
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
        q_ns <= IR_Fetch_0;
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
                    when ADD_AB => q_ns <= ADD_AB_4;
                    when SUB_AB => q_ns <= SUB_AB_4;
                    when AND_AB => q_ns <= AND_AB_4;
                    when OR_AB => q_ns <= OR_AB_4;
                    when INC_A => q_ns <= INC_A_4;
                    when INC_B => q_ns <= INC_B_4;
                    when DEC_A => q_ns <= DEC_A_4;
                    when DEC_B => q_ns <= DEC_B_4;
                    when JMP => q_ns <= JMP_4;
                    when JMP_IN => q_ns <= JMP_IN_4;
                    when JMP_NN => q_ns <= JMP_NN_4;
                    when JMP_NC => q_ns <= JMP_NC_4;
                    when JMP_IC => q_ns <= JMP_IC_4;
                    when JMP_IZ => q_ns <= JMP_IZ_4;
                    when JMP_NZ => q_ns <= JMP_NZ_4;
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
            -- Arithmetic and Logic --
                when ADD_AB_4 => q_ns <= IR_Fetch_0;
                when SUB_AB_4 => q_ns <= IR_Fetch_0;
                when AND_AB_4 => q_ns <= IR_Fetch_0;
                when OR_AB_4 => q_ns <= IR_Fetch_0;
                when INC_A_4 => q_ns <= IR_Fetch_0;
                when INC_B_4 => q_ns <= IR_Fetch_0;
                when DEC_B_4 => q_ns <= IR_Fetch_0;
                when DEC_A_4 => q_ns <= IR_Fetch_0;
            -- Branches --
                when JMP_4 => q_ns <= JMP_5;
                when JMP_5 => q_ns <= JMP_6;
                when JMP_6 => q_ns <= IR_Fetch_0;
                when JMP_IZ_4 => q_ns <= JMP_IZ_5;
                when JMP_IZ_5 => 
                    if nzc_alu_flags(1) = '1' then 
                        q_ns <= JMP_6; 
                    else 
                        q_ns <= IR_Fetch_0; 
                    end if;
                when JMP_NZ_4 => q_ns <= JMP_NZ_5;
                when JMP_NZ_5 => 
                    if nzc_alu_flags(1) = '0' then 
                        q_ns <= JMP_6; 
                    else 
                        q_ns <= IR_Fetch_0; 
                    end if;
                when JMP_IC_4 => q_ns <= JMP_IC_5;
                when JMP_IC_5 => 
                    if nzc_alu_flags(0) = '1' then 
                        q_ns <= JMP_6; 
                    else 
                        q_ns <= IR_Fetch_0; 
                    end if;
                when JMP_NC_4 => q_ns <= JMP_NC_5;
                when JMP_NC_5 => 
                when JMP_IN_4 => q_ns <= JMP_IN_5;
                when JMP_IN_5 => 
                    if nzc_alu_flags(2) = '1' then 
                        q_ns <= JMP_6; 
                    else 
                        q_ns <= IR_Fetch_0; 
                    end if;
                when JMP_NN_4 => q_ns <= JMP_NN_5;
                when JMP_NN_5 => 
                    if nzc_alu_flags(2) = '0' then 
                        q_ns <= JMP_6; 
                    else 
                        q_ns <= IR_Fetch_0; 
                    end if;
            when others => NULL;
        end case ;
    end process ; -- nsd

    od : process( q_s )
    begin
        ir_fetch <= '0'; mar_fetch <= '0'; pc_fetch <= '0'; pc_inc <= '0'; a_fetch <= '0'; b_fetch <= '0'; flag_fetch <= '0'; write_enable <= '0';
        data_bus0_sel <= "00"; data_bus1_sel <= "00"; alu_sel <= NO_OP_CMD;
        case( q_s ) is
            when IR_Fetch_0 => data_bus0_sel <= "00"; data_bus1_sel <= "00"; mar_fetch <= '1';
            when IR_Fetch_1 => pc_inc <= '1';
            when IR_Fetch_2 => ir_fetch <= '1'; data_bus0_sel <= "10";
            when LDA_IMM_4 | LDB_IMM_4 | LDA_DIR_4 | LDB_DIR_4 | STA_DIR_4 | STB_DIR_4 => mar_fetch <= '1'; data_bus0_sel <= "00"; data_bus1_sel <= "00";
            when LDA_IMM_5 | LDB_IMM_5 | STA_DIR_5 | STB_DIR_5 => pc_inc <= '1';
            -- Load --
                -- Immediate --
                    when LDA_IMM_6 => a_fetch <= '1'; data_bus0_sel <= "10";
                    when LDB_IMM_6 => b_fetch <= '1'; data_bus0_sel <= "10";
                -- Directe --
                    when LDA_DIR_5 | LDB_DIR_5 => mar_fetch <= '1'; data_bus0_sel <= "10";
                    when LDA_DIR_6 | LDB_DIR_6 => pc_inc <= '1';
                    when LDA_DIR_7 => a_fetch <= '1'; data_bus0_sel <= "10";
                    when LDB_DIR_7 => b_fetch <= '1'; data_bus0_sel <= "10"; 
            -- Store --
                when STA_DIR_6 | STB_DIR_6 => data_bus0_sel <= "10"; mar_fetch <= '1';
                when STA_DIR_7 => data_bus1_sel <= "01"; write_enable <= '1';
                when STB_DIR_7 => data_bus1_sel <= "10"; write_enable <= '1';
            -- Arithmetic and Logic --
                when ADD_AB_4 => alu_sel <= ADD_CMD; data_bus0_sel <= "01"; a_fetch <= '1'; data_bus1_sel <= "10";
                when SUB_AB_4 => alu_sel <= SUB_CMD; data_bus0_sel <= "01"; a_fetch <= '1'; data_bus1_sel <= "10";
                when AND_AB_4 => alu_sel <= AND_CMD; data_bus0_sel <= "01"; a_fetch <= '1'; data_bus1_sel <= "10";
                when OR_AB_4 => alu_sel <= OR_CMD; data_bus0_sel <= "01"; a_fetch <= '1'; data_bus1_sel <= "10";
                when INC_A_4 => alu_sel <= INC_A_CMD; data_bus0_sel <= "01"; a_fetch <= '1'; 
                when INC_B_4 => alu_sel <= INC_B_CMD; data_bus0_sel <= "01"; data_bus1_sel <= "10"; b_fetch <= '1';
                when DEC_B_4 => alu_sel <= DEC_B_CMD; data_bus0_sel <= "01"; data_bus1_sel <= "10"; b_fetch <= '1';                
                when DEC_A_4 => alu_sel <= DEC_A_CMD; data_bus0_sel <= "01"; a_fetch <= '1';  
            -- Branches --
                when JMP_4 => mar_fetch <= '1'; data_bus1_sel <= "00"; data_bus0_sel <= "00";
                when JMP_5 => NULL;
                when JMP_6 => data_bus0_sel <= "10"; pc_fetch <= '1';
                when JMP_IN_4 | JMP_NN_4 | JMP_IC_4 | JMP_NC_4 | JMP_IZ_4 | JMP_NZ_4 => 
                            mar_fetch <= '1'; data_bus1_sel <= "00"; data_bus0_sel <= "00"; flag_fetch <= '1';
                when JMP_IN_5 | JMP_NN_5 | JMP_IC_5 | JMP_NC_5 | JMP_IZ_5 | JMP_NZ_5 => pc_inc <= '1';
            when others =>  NULL;
        end case ;
    end process ; -- od

end bh ; -- bh