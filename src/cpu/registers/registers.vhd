library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is
  port (
    clk, reset, ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch  : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    data_bus0_sel, data_bus1_sel : in std_logic_vector(1 downto 0);
    alu_sel : in std_logic_vector(3 downto 0);
    ir_out, address, data_out : out std_logic_vector(7 downto 0);
    nzc_flags : out std_logic_vector(2 downto 0) -- negativ, zero, carry 
  ) ;
end registers;

architecture bh of registers is

    signal data_bus0, data_bus1 : std_logic_vector(7 downto 0) := x"00";
    signal npc : std_logic_vector(7 downto 0) := x"00";
    signal a, b : std_logic_vector(7 downto 0) := x"00";
    signal alu_out : std_logic_vector(7 downto 0) := x"00";
    signal nzc_alu_flags : std_logic_vector(2 downto 0) := "000";
    component alu
        port (
          a, b : in std_logic_vector(7 downto 0);
          alu_out : out std_logic_vector(7 downto 0);
          alu_sel : in std_logic_vector(3 downto 0);
          zero, carry, negativ : out std_logic
        ) ;
    end component;

    component ir 
        port (
          clk, reset, ir_fetch : in std_logic;
          data_bus : in std_logic_vector(7 downto 0);  
          ir_out : out std_logic_vector(7 downto 0)  
        ) ;
    end component;

    component mar
        port (
          clk, reset, mar_fetch : in std_logic;
          data_bus : in std_logic_vector(7 downto 0);  
          mar_out : out std_logic_vector(7 downto 0)  
        ) ;
    end component;

    component pc is
        port (
          clk, reset, pc_fetch, pc_inc : in std_logic;
          data_bus : in std_logic_vector(7 downto 0);  
          pc_out : out std_logic_vector(7 downto 0)  
        ) ;
    end component;

    component gpr 
        port (
          clk, reset, a_fetch, b_fetch : in std_logic;
          data_bus : in std_logic_vector(7 downto 0);  
          a, b : out std_logic_vector(7 downto 0)  
        ) ;
    end component;

    component fr 
        port (
          clk, reset, fr_fetch : in std_logic;
          fr_in : in std_logic_vector(2 downto 0);  
          fr_out : out std_logic_vector(2 downto 0)  
        ) ;
    end component;
begin

    ir0: ir port map (clk => clk, reset => reset, ir_fetch => ir_fetch, data_bus => data_bus0, ir_out => ir_out);
    mar0: mar port map (clk => clk, reset => reset, mar_fetch => mar_fetch, data_bus => data_bus0, mar_out => address);
    pc0: pc port map (clk => clk, reset => reset, pc_fetch => pc_fetch, pc_inc => pc_inc, data_bus => data_bus0, pc_out => npc);
    gpr0 : gpr port map (clk => clk, reset => reset, a_fetch => a_fetch, b_fetch => b_fetch, data_bus => data_bus0, a => a, b => b);
    alu_u:alu port map( a => a, b => b, 
                        alu_out => alu_out, alu_sel => alu_sel, 
                        negativ => nzc_alu_flags(2), zero => nzc_alu_flags(1), 
                        carry => nzc_alu_flags(0));
    fr0 : fr port map(clk => clk, reset => reset, fr_fetch => flag_fetch, fr_in => nzc_alu_flags, fr_out => nzc_flags);
    data_bus0_mux : process( data_bus0_sel, data_in, alu_out, data_bus1 )
    begin
        case( data_bus0_sel ) is
        
            when "00" => data_bus0 <= data_bus1;
            when "01" => data_bus0 <= alu_out;
            when "10" => data_bus0 <= data_in;
            when others => data_bus0 <= x"00";
        
        end case ;
    end process ; -- data_bus0_mux

    data_bus1_mux : process( data_bus1_sel, a, b, npc )
    begin
        case( data_bus1_sel ) is
        
            when "00" => data_bus1 <= npc;
            when "01" => data_bus1 <= a;
            when "10" => data_bus1 <= b;
            when others => data_bus1 <= x"00";
        
        end case ;
    end process ; -- data_bus1_mux

    data_out <= data_bus1;

end bh ; -- bh