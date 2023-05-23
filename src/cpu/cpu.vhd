library ieee;
use ieee.std_logic_1164.all;

entity cpu is
  port (
    clk, reset : in std_logic;
    port_in0 : in std_logic_vector(7 downto 0);
    port_in1 : in std_logic_vector(7 downto 0);
    port_in2 : in std_logic_vector(7 downto 0);
    port_in3 : in std_logic_vector(7 downto 0);
    port_in4 : in std_logic_vector(7 downto 0);
    port_in5 : in std_logic_vector(7 downto 0);
    port_in6 : in std_logic_vector(7 downto 0);
    port_in7 : in std_logic_vector(7 downto 0);
    port_out0 : out std_logic_vector(7 downto 0);
    port_out1 : out std_logic_vector(7 downto 0);
    port_out2 : out std_logic_vector(7 downto 0);
    port_out3 : out std_logic_vector(7 downto 0);
    port_out4 : out std_logic_vector(7 downto 0);
    port_out5 : out std_logic_vector(7 downto 0);
    port_out6 : out std_logic_vector(7 downto 0);
    port_out7 : out std_logic_vector(7 downto 0)
  ) ;
end cpu;

architecture bh of cpu is
    signal ir : std_logic_vector(7 downto 0) := (others => '0');
    signal nzc_alu_flags : std_logic_vector(2 downto 0) := (others => '0');
    signal alu_sel : std_logic_vector(3 downto 0) := (others => '0');
    signal data_bus0_sel, data_bus1_sel : std_logic_vector(1 downto 0) := (others => '0');
    signal ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch, write_enable : std_logic := '0';
    component control_unit
        port (
          clk, reset : in std_logic;
          ir : in std_logic_vector(7 downto 0);
          nzc_alu_flags : in std_logic_vector(2 downto 0);
          alu_sel : out std_logic_vector(3 downto 0);
          data_bus0_sel, data_bus1_sel : out std_logic_vector(1 downto 0);
          ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch, write_enable : out std_logic
        ) ;
    end component;
    signal from_mem : std_logic_vector(7 downto 0) := (others => '0');
    signal to_mem : std_logic_vector(7 downto 0) := (others => '0');
    signal address : std_logic_vector(7 downto 0) := (others => '0');
    component registers
        port (
          clk, reset, ir_fetch, mar_fetch, pc_fetch, pc_inc, a_fetch, b_fetch, flag_fetch  : in std_logic;
          data_in : in std_logic_vector(7 downto 0);
          data_bus0_sel, data_bus1_sel : in std_logic_vector(1 downto 0);
          alu_sel : in std_logic_vector(3 downto 0);
          ir_out, address, data_out : out std_logic_vector(7 downto 0);
          nzc_flags : out std_logic_vector(2 downto 0) -- negativ, zero, carry 
        ) ;
    end component;

    component memory
        port (
          clk, reset, write_enable : in std_logic;
          address, data_in : in std_logic_vector(7 downto 0);
          port_in0 : in std_logic_vector(7 downto 0);
          port_in1 : in std_logic_vector(7 downto 0);
          port_in2 : in std_logic_vector(7 downto 0);
          port_in3 : in std_logic_vector(7 downto 0);
          port_in4 : in std_logic_vector(7 downto 0);
          port_in5 : in std_logic_vector(7 downto 0);
          port_in6 : in std_logic_vector(7 downto 0);
          port_in7 : in std_logic_vector(7 downto 0);
          port_out0 : out std_logic_vector(7 downto 0);
          port_out1 : out std_logic_vector(7 downto 0);
          port_out2 : out std_logic_vector(7 downto 0);
          port_out3 : out std_logic_vector(7 downto 0);
          port_out4 : out std_logic_vector(7 downto 0);
          port_out5 : out std_logic_vector(7 downto 0);
          port_out6 : out std_logic_vector(7 downto 0);
          port_out7 : out std_logic_vector(7 downto 0);
          data_out : out std_logic_vector(7 downto 0)
          );
    end component;

begin
    cu : control_unit port map(clk => clk, 
        reset => reset, 
        ir => ir, 
        nzc_alu_flags => nzc_alu_flags, 
        alu_sel => alu_sel, 
        data_bus0_sel => data_bus0_sel, 
        data_bus1_sel => data_bus1_sel,
        ir_fetch => ir_fetch,
        mar_fetch => mar_fetch,
        pc_fetch => pc_fetch,
        pc_inc => pc_inc,
        a_fetch => a_fetch,
        b_fetch => b_fetch,
        flag_fetch => flag_fetch,
        write_enable => write_enable);
    rgs : registers port map(clk => clk, 
        reset => reset, 
        ir_out => ir, 
        nzc_flags => nzc_alu_flags, 
        alu_sel => alu_sel, 
        data_bus0_sel => data_bus0_sel, 
        data_bus1_sel => data_bus1_sel,
        ir_fetch => ir_fetch,
        mar_fetch => mar_fetch,
        pc_fetch => pc_fetch,
        pc_inc => pc_inc,
        a_fetch => a_fetch,
        b_fetch => b_fetch,
        flag_fetch => flag_fetch,
        address => address,
        data_out => to_mem,
        data_in => from_mem);
    mem : memory port map(
        clk => clk, reset => reset, write_enable => write_enable,
        address => address, data_in => to_mem,
        port_in0 => port_in0,
        port_in1 => port_in1,
        port_in2 => port_in2,
        port_in3 => port_in3,
        port_in4 => port_in4,
        port_in5 => port_in5,
        port_in6 => port_in6,
        port_in7 => port_in7,
        port_out0 => port_out0,
        port_out1 => port_out1,
        port_out2 => port_out2,
        port_out3 => port_out3,
        port_out4 => port_out4,
        port_out5 => port_out5,
        port_out6 => port_out6,
        port_out7 => port_out7,
        data_out => from_mem);

end bh ; -- bh